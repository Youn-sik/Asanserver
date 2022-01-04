const express = require('express');
const router = express.Router();
const db = require('../../db');
const fs = require('fs');
const path = require('path');
const multer = require('multer');
const ffmpeg = require('fluent-ffmpeg');
const site_info_json = fs.readFileSync(path.join(__dirname, "../../cloud44.json"));
const site = JSON.parse(site_info_json);

let moment = require('moment');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");
let time = moment().format('YYYY-MM-DD HH:mm:ss');

router.get('/', async(req, res) =>{
    try{
        let result = {};

        db.query('select * from g_main_list', (err,main_list)=> {
            if(err) console.log(err);
            // console.log(main_list);
            if(main_list.length != 0){
                let main_list_arr = [];

                for(let i=0; i<main_list.length; i++){
                    let main_list_obj = new Object();
                    main_list_obj = main_list[i];
                    main_list_obj.update_time = main_list_obj.update_time.toISOString().slice(0, 19).replace('T', ' ');
                    main_list_arr.push(main_list_obj);
                }
                
                result = {
                    result: "ok",
                    values: main_list_arr
                };
                res.send(result);
            } else {
                result = {
                    result : "fail",
                    values: [{}]
                };
                res.send(result)
            }
        });
    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})
//영상 저장 부분은 router 따로 해서 등록하고, 밑의 / 에서 파일 네임과 경로를 fs를 통해 가져와서 DB 에 저장하자.
router.post('/', async(req, res) =>{ //명상 영상 등록
    try{
        let result = {};
        let name = req.body.name;
        let update_time = time;
        let stb_sn = req.body.stb_sn
        let start = req.body.start;
        let end = req.body.end;
        let user = "admin"; //req.body.user;
        let file_name = req.body.file_name;
        let file_name_save = update_time.replace(" ", "_")+"_"+file_name;
        let file_ext = path.extname(req.body.file_name);
        let file_path = req.body.file_path;
        let file_url = site.base_server_backend_loacal_url+"/contents/meditation/"+file_name_save;

        // console.log(file_name_save);
        // console.log(file_ext);
        // console.log(file_path);
        // console.log(file_url);

        function stb_query(){
            return new Promise((resolve, reject)=>{
                db.query('select * from g_stb where main_stb_sn = ? or sub_stb_sn = ?', [stb_sn, stb_sn], (err, stb)=> {
                    if(err) console.log(err);
                    if(stb.length != 0){
                        let main_sub_stb_sn = [];
                        main_sub_stb_sn.push(stb[0].main_stb_sn);
                        main_sub_stb_sn.push(stb[0].sub_stb_sn);
                        resolve(main_sub_stb_sn)
                    } else {
                        result = {
                            "stb_sn": stb_sn,
                            "result": "fail"
                        }
                        reject(result)
                    }
                })
            })
        }

        function get_main_order(main_sub_stb_sn){
            return new Promise((resolve, reject)=>{
                db.query('select * from g_main where stb_sn = ? or stb_sn = ?', main_sub_stb_sn, (err, stb)=> {
                    if(err) console.log(err);
                    if(stb.length != 0){
                        // console.log(stb);
                        let g_main_order = stb[0].order;
                        resolve(g_main_order)
                    } else {
                        result = {
                            "stb_sn": stb_sn,
                            "result": "fail"
                        }
                        reject(result)
                    }
                })
            })
        }

        // DB에 작성
        //g_main_order 부분 명상 등록 할 때 세탑 지정
        function meditation_reg(g_main_order){
            return new Promise((resolve, reject)=>{
                db.query('insert into g_main_list (name, update_time, g_main_order, start, end, user, file_path, file_name, file_ext, file_url) '+
                'values (?,?,?,?,?,?,?,?,?,?)',
                [name, update_time, g_main_order, start, end, user, file_path, file_name, file_ext, file_url], (err,main_list)=> {
                    if(err) {
                        console.log(err);
                        result = {
                            result : "fail"
                        };
                        reject(result)
                    }
                    // console.log(main_list);    
        
                    result = {
                        result: "ok"
                    };
                    resolve(result)
                });
            });
        }

        stb_query()
        .then((main_sub_stb_sn)=> {
            return get_main_order(main_sub_stb_sn);
        })
        .then((g_main_order)=> {
            return meditation_reg(g_main_order);
        })
        .then((result)=> {
            res.send(result);
        })
        .catch((reject)=> {
            console.log(reject);
        })  
    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

//영상 저장
router.post('/upload', async(req, res)=> {
    try {
        console.log("video upload")
        var storage = multer.diskStorage({
            destination: (req, file, cb) => {
                cb(null, site.base_server_document+"/uploads/contents/meditation/")
            },
            filename: (req, file, cb) => {
                cb(null, `${time.replace(" ", "_")}_${file.originalname}`)
            },
            fileFilter: (req, file, cb) => {
                const ext = path.extname(file.originalname)
                if (ext !== '.mp4') {
                    return cb(res.status(400).end('only jpg, png, mp4 is allowed'), false);
                }
                cb(null, true)
            }
        })

        var upload = multer({ storage: storage }).single("file")

        upload(req, res, err => {
            if (err) {
                return res.json({ success: false, err })
            }
            return res.json({ success: true, filePath: res.req.file.path, fileName: res.req.file.filename })
        })

    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

//썸네일 제작
router.post('/thumbnail', async(req, res)=> {
    try {
        console.log("thumbnail here");
        console.log(req.body);
        let thumbsFilePath = "";
        let fileDuration = "";

        ffmpeg.ffprobe(req.body.filePath, function(err, metadata){
            console.dir(metadata);
            console.log(metadata.format.duration);

            fileDuration = metadata.format.duration;
        })


        ffmpeg(req.body.filePath)
            .on('filenames', function (filenames) {
                console.log('Will generate ' + filenames.join(', '))
                thumbsFilePath = site.base_server_document+"/uploads/contents/meditation/thumbnails/" + filenames[0];
            })
            .on('end', function () {
                console.log('Screenshots taken');
                return res.json({ success: true, thumbsFilePath: thumbsFilePath, fileDuration: fileDuration})
            })
            .screenshots({
                // Will take screens at 20%, 40%, 60% and 80% of the video
                count: 3,
                folder: site.base_server_document+"/uploads/contents/meditation/thumbnails/",
                size:'320x240',
                // %b input basename ( filename w/o extension )
                filename:'thumbnail-%b.png'
            });

    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

//명상 영상 배포 (세탑 지정) 우선 영상으로만 한개의 데이터 전송으로
router.post('/distribution', async(req, res)=> {
    try {
        // console.log(req.body);
        let result = {};
        let values = [];
        let stb_sn =req.body.values[0].stb_sn;
        let name = req.body.values[0].name;
        let update_time = req.body.values[0].update_time;
        let type;
        let file_url;

        function meditation_dis(){
            return new Promise((resolve, reject)=>{
                db.query('select * from g_main_list where update_time = ? and name = ?', [update_time, name], (err, main_list)=> {
                    if(err) console.log(err);
                    // console.log(main_list);

                    if(main_list.length != 0){
                        file_url = (main_list[0].file_url);
                        let type_tmp = main_list[0].file_ext;
                        if(type_tmp == '.mp4' || type_tmp == '.mov') type = ("video");
                        else if(type_tmp == '.jpg' || type_tmp == '.jpeg' || type_tmp == '.jfif' || type_tmp == '.png' || type_tmp == '.gif') type = ("image");
                        else if(type_tmp == '.mp3') type = ("bgm")

                        values.push({
                            "stb_sn": stb_sn,
                            "name": name,
                            "update_time": update_time,
                            "type": type,
                            "url": file_url
                        })
                        console.log(values);
                    } else {
                        
                    }          
                    
                })
            });
        }
        
        meditation_dis()
        .then(()=> {
            result = {
                "values": values
            }
            console.log(result);
        })
        
    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

router.delete('/', async(req, res) =>{
    try{
        let result = {};
        let update_time = req.body.update_time;
        let name = req.body.name;

        db.query('delete from g_main_list where update_time = ? and name = ?', [update_time, name], (err,main_list)=> {
            if(err) {
                console.log(err);
                result = {
                    result : "fail"
                };
                res.send(result)
            }
            // console.log(main_list);

            result = {
                result: "ok"
            };
            res.send(result);
        });
    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

module.exports = router;