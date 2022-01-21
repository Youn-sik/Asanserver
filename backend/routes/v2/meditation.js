const express = require('express');
const router = express.Router();
const db = require('../../db');
const fs = require('fs');
const path = require('path');
const multer = require('multer');
const ffmpeg = require('fluent-ffmpeg');
const exec = require("child_process").exec;
const xlsx = require("node-xlsx")
const site_info_json = fs.readFileSync(path.join(__dirname, "../../cloud44.json"));
const site = JSON.parse(site_info_json);
const client = require('../../mqtt/mqtt_load');

client.on('connect', () => {
    console.log('MQTT Connected')
})

let moment = require('moment');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");

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
        // console.log("meditation register");
        let result = {};
        let name = req.body.name;
        let update_time = moment().format('YYYY-MM-DD HH:mm:ss');
        let stb_sn = req.body.stb_sn
        let start = "08:00";
        let end = "10:00";
        let user = "admin"; //req.body.user;
        let file_name = req.body.file_name;
        let file_ext = path.extname(req.body.file_name);
        let file_path = req.body.file_path;
        let file_url = site.base_server_backend_loacal_url+"/uploads/contents/meditation/"+file_name;

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

        //프론트에서 메인 목록 보여주고 메인 이름 받아와서 밑의 조건에 메인 이름 넣어서 대기화면 추가하도록 하기
        function get_main_order(main_sub_stb_sn){
            return new Promise((resolve, reject)=>{
                db.query('select * from g_main where stb_sn = ? or stb_sn = ?', main_sub_stb_sn, (err, stb)=> {
                    if(err) console.log(err);
                    if(stb.length != 0){
                        // console.log(stb);
                        let g_main_order = stb[0].uid;
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
                db.query("insert into g_main_list (name, update_time, start, end, g_main_uid, user, file_path, file_name, file_ext, file_url) "+
                "values (?,?,?,?,?,?,?,?,?,?)",
                [name, update_time, start, end, g_main_order, user, file_path, file_name, file_ext, file_url], (err,main_list)=> {
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

//스케줄 엑셀 파일 파싱
router.post('/excelScheduleSave', async(req, res)=> {
    try{        
        let storage = multer.diskStorage({
            destination: (req, file, cb) => {
                cb(null, site.base_server_document+"/upload/csv/")
            },
            filename: (req, file, cb) => {
                cb(null, `${file.originalname}`)
            }
        })

        let upload = multer({ 
            storage: storage,
            fileFilter: (req, file, cb) => {
                const ext = path.extname(file.originalname);
                if (ext !== '.xlsx') {
                    // return cb(res.status(400).end('only xlsx file is allowed'), false);
                    res.json({result: false})
                    cb(null, false)
                    return;
                }
                cb(null, true);
            }
        }).single("file");

        upload(req, res, err => {
            // console.log(res.req.file);
            if (err) {
                return res.json({ result: false, err })
            }

            //xlsxto csv logic
            let xlsxObj = xlsx.parse(res.req.file.path);
            let xlsxRows = [];
            let writeStr = "";

            for(let i=0; i<xlsxObj.length; i++) {
                let xlsxSheet = xlsxObj[i];
                for(let j=0; j<xlsxSheet['data'].length; j++) {
                    // console.log(xlsxSheet['data'][j]);
                    xlsxRows.push(xlsxSheet['data'][j]);
                }
            }

            for(let i=0; i<xlsxRows.length; i++) {
                writeStr += xlsxRows[i].join(",") + "\n";
            }

            fs.writeFile(res.req.file.destination + "schedule.csv", writeStr, (err)=> {
                if(err) {
                    console.log(err)
                    return res.json({result: "error"});
                } else {
                    return res.json({ result: true, filePath: res.req.file.path, fileName: res.req.file.filename });
                }
            })
        })

    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

//스케줄 배포
router.post('/excelScheduleDistribution', async(req, res)=> {
    try{
        exec("cd ~/asan/backend; bash ExcelImportToMysql_schedule_rewrite.sh;", (err, stdout, stderr)=> {
            if(err) {
                console.log(`error: ${err.message}`);
                return ;
            }
            if(stderr) {
                // console.log(`stderr:`);
                // console.log(stderr)
            }
            // console.log(stdout)
            let Out = stdout.split('\n');
            let filterdOut = Out.filter((element)=> element !== '');
            console.log(filterdOut);
            filterdOut.forEach(element => {
                if(element == "Success Script") {
                    res.json({result: true});
                    return ;
                } else if(element == "Fail Script") {
                    res.json({result: false})
                    return ;
                }
            })
        })

    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

//영상 저장
router.post('/upload', async(req, res)=> {
    try {
        let time = moment().format('YYYY-MM-DD HH:mm:ss');
        var storage = multer.diskStorage({
            destination: (req, file, cb) => {
                cb(null, site.base_server_document+"/uploads/contents/meditation/")
            },
            filename: (req, file, cb) => {
                cb(null, `${time.replace(" ", "_")}_${file.originalname}`)
            },
            fileFilter: (req, file, cb) => {
                const ext = path.extname(file.originalname);
                if (ext !== '.mp4' || ext !== '.mp3') {
                    return cb(res.status(400).end('only mp3, mp4 is allowed'), false);
                }
                cb(null, true);
                // console.log("video uploaded")
            }
        })

        var upload = multer({ storage: storage }).single("file")

        upload(req, res, err => {
            // console.log(res.req.file);
            let file_ext = path.extname(res.req.file.filename);

            if (err) {
                return res.json({ success: false, err })
            }
            return res.json({ success: true, filePath: res.req.file.path, fileName: res.req.file.filename, ext:file_ext  })
        })

    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

//썸네일 제작
router.post('/thumbnail', async(req, res)=> {
    try {
        // console.log(req.body);
        let fileExt = path.extname(req.body.fileName);
        if(fileExt !== ".mp4") {
            res.json({success: false});
            return 0;
        }
        let thumbsFilePath = "";
        let fileDuration = "";

        ffmpeg.ffprobe(req.body.filePath, function(err, metadata){
            // console.dir(metadata);
            // console.log(metadata.format.duration);

            fileDuration = metadata.format.duration;
        })


        ffmpeg(req.body.filePath)
            .on('filenames', function (filenames) {
                // console.log('Will generate ' + filenames.join(', '))
                thumbsFilePath = "/uploads/contents/meditation/thumbnails/" + filenames[0];
            })
            .on('end', function () {
                // console.log('Screenshots created');
                return res.json({ success: true, thumbsFilePath: thumbsFilePath, fileDuration: fileDuration})
            })
            .screenshots({
                count: 1,
                folder: site.base_server_document+"/uploads/contents/meditation/thumbnails/",
                size:'450x240',
                // %b input basename ( filename w/o extension )
                filename:'thumbnail-%b.png'
            });

    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

router.post('/distribution', async(req, res)=> {
    try {
        // console.log(req.body);
        let result = {};
        let values = [];
        let stb_sn = req.body.stb_sn;
        let uid = req.body.values;
        let time = moment().format('YYYY-MM-DD HH:mm:ss');
        let type;
        let file_url;

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
                            "result": "fail",
                            "value": [{}]
                        }
                        reject(result)
                    }
                })
            })
        }

        function main_get_uid_query(main_sub_stb_sn){
            return new Promise((resolve, reject)=>{
                db.query('select * from g_main where stb_sn = ? or stb_sn = ?', main_sub_stb_sn, (err, stb)=> {
                    // console.log(stb);
                    if(err) {
                        console.log(err);
                        result = {
                            "stb_sn": stb_sn,
                            "result": "fail",
                            "value": [{}]
                        }
                        reject(result)
                    }
                    resolve([...main_sub_stb_sn, stb[0].uid]);
                })
            })
        }

        function schedule_update_time_query(main_sub_stb_sn_and_main_uid){
            return new Promise((resolve, reject)=>{
                db.query('update g_schedule set update_time = ? where main_uid = ?',[time, main_sub_stb_sn_and_main_uid[2]], (err, stb)=> {
                    // console.log(stb);
                    if(err) {
                        console.log(err);
                        result = {
                            "stb_sn": stb_sn,
                            "result": "fail",
                            "value": [{}]
                        }
                        reject(result)
                    }
                    let main_sub_stb_sn = [main_sub_stb_sn_and_main_uid[0], main_sub_stb_sn_and_main_uid[1]];
                    resolve(main_sub_stb_sn);
                })
            })
        }

        function distribution_update_time_query(main_sub_stb_sn){
            return new Promise((resolve, reject)=>{
                db.query('update g_distribution set update_time = ? where stb_sn = ? or stb_sn = ?',[time, ...main_sub_stb_sn], (err, stb)=> {
                    // console.log(stb);
                    if(err) {
                        console.log(err);
                        result = {
                            "stb_sn": stb_sn,
                            "result": "fail",
                            "value": [{}]
                        }
                        reject(result)
                    }
                    resolve(main_sub_stb_sn);
                })
            })
        }

        function main_update_time_query(main_sub_stb_sn){
            return new Promise((resolve, reject)=>{
                db.query('update g_main set update_time = ? where stb_sn = ? or stb_sn = ?',[time, ...main_sub_stb_sn], (err, stb)=> {
                    // console.log(stb);
                    if(err) {
                        console.log(err);
                        result = {
                            "stb_sn": stb_sn,
                            "result": "fail",
                            "value": [{}]
                        }
                        reject(result)
                    }
                    resolve();
                })
            })
        }

        function main_list_distribution_query(uid){
            return new Promise((resolve, reject)=>{
                let values = [];
                for(let i=0; i<uid.length; i++){
                    db.query('select g_main.stb_sn, g_main.name, g_main.update_time, g_main_list.file_url, g_main_list.file_ext from g_main_list '+
                    'inner join g_main on g_main.uid = g_main_list.g_main_uid where g_main_list.uid = ?', uid[i], (err, main_list)=> {
                        if(err) console.log(err);
                        // console.log(main_list);
                        if(main_list.length != 0){
                            let obj = {};
                            if(main_list[0].file_ext == '.mp3'){
                                obj = {
                                    "type": "music",
                                    "file_url": main_list[0].file_url
                                }
                            } else if (main_list[0].file_ext == '.mp4'){
                                obj = {
                                    "type": "video",
                                    "file_url": main_list[0].file_url
                                }
                            } else {
                                obj = {
                                    "type": main_list[0].file_ext,
                                    "file_url": main_list[0].file_url
                                }
                            }
                            values.push(obj);
                        } else {
                            result = {
                                "stb_sn": stb_sn,
                                "result": "fail",
                                "value": [{}]
                            }
                            reject(result);
                            return 0;
                        }
                        if(i == uid.length-1){
                            result = {
                                "stb_sn": stb_sn,
                                "name": main_list[0].name,
                                "update_time": main_list[0].update_time,
                                "result": "ok",
                                "value": values
                            }
                            resolve(result);
                        }
                    });
                }
                
            })
        }

        stb_query()
        .then((main_sub_stb_sn)=> {
            return main_get_uid_query(main_sub_stb_sn);
        })
        .then((main_sub_stb_sn_and_main_uid)=> {
            return schedule_update_time_query(main_sub_stb_sn_and_main_uid);
        })
        .then((main_sub_stb_sn)=> {
            return distribution_update_time_query(main_sub_stb_sn);
        })
        .then((main_sub_stb_sn)=> {
            return main_update_time_query(main_sub_stb_sn);
        })
        .then(()=> {
            return main_list_distribution_query(uid);
        })
        .then(()=> {
            // console.log((result)) 
            res.send(result);
            client.publish('/schedule/main/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                if(err) console.log(err);
            })
        }).catch((reject)=> {
            console.log(reject);
        }) 
        
    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

router.delete('/', async(req, res) =>{
    try{
        // console.log(req.body);
        let result = {};
        let uid = req.body.uid;
        
        for(let i=0; i<uid.length; i++){
            db.query('delete from g_main_list where uid = ?', uid[i], (err,main_list)=> {
                if(err) {
                    console.log(err);
                    result = {
                        result : "fail"
                    };
                    res.send(result);
                    return 0;
                } else {
                    // console.log(main_list);
                }
            });
            if(i == uid.length-1){
                result = {
                    result: "ok"
                };
                res.send(result);
            }
        }
    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

module.exports = router;