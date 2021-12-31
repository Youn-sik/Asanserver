const express = require('express');
const router = express.Router();
const db = require('../../db');
const fs = require('fs');
const path = require('path');
const site_info_json = fs.readFileSync(path.join(__dirname, "../../cloud44.json"));
const site = JSON.parse(site_info_json);

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

router.post('/', async(req, res) =>{ //명상 영상 등록
    try{
        let result = {};
        let name = req.body.name;
        let update_time = req.body.update_time;
        let stb_sn = req.body.stb_sn
        let start = req.body.start;
        let end = req.body.end;
        let user = "admin"; //req.body.user;
        let file_name = req.body.file_name;
        let file_name_save = update_time.replace(" ", "_")+"_"+file_name;
        let file_ext = path.extname(req.body.file_name);
        let file_path = "/home/asan/asan/backend/uploads/contents/meditation/"+file_name_save;
        let file_url = site.base_server_backend_loacal_url+"/contents/meditation/"+file_name_save;

        // console.log(user);
        // console.log(update_time);
        // console.log(name);
        // console.log(file_path);
        // console.log(file_name);
        // console.log(file_ext);

        // 파일 업로드 부분 작업
        function file_upload(){
            return new Promise((resolve, reject)=>{

                resolve(main_sub_stb_sn)
                reject(result)
            });
        }

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

//명상 영상 배포 (세탑 지정)
router.post('/distribution', async(req, res)=> {
    try {
        // console.log(req.body);
        let result = {};
        let values = [];
        let stb_sn = [];
        let name = [];
        let update_time = [];
        let type = [];
        let file_url = [];

        let value_I = req.body.values.length;

        function meditation_dis(){
            return new Promise((resolve, reject)=>{
                let i;
                for(i=0; i<value_I; i++){
                    stb_sn.push(req.body.values[i].stb_sn);
                    name.push(req.body.values[i].name);
                    update_time.push(req.body.values[i].update_time);
                

                    let query_str = "select * from g_main_list where update_time = ? and name = ?;";
                    let data = [update_time[i], name[i]];
                }
                db.query('select * from g_main_list where update_time = ? and name = ?', [update_time[0], name[0]], (err, main_list)=> {
                    if(err) console.log(err);
                    // console.log(main_list);

                    if(main_list.length != 0){
                        file_url.push(main_list[0].file_url);
                        let type_tmp = main_list[0].file_ext;
                        if(type_tmp == '.mp4' || type_tmp == '.mov') type.push("video");
                        else if(type_tmp == '.jpg' || type_tmp == '.jpeg' || type_tmp == '.jfif' || type_tmp == '.png' || type_tmp == '.gif') type.push("image");
                        else if(type_tmp == '.mp3') type.push("bgm")

                        values.push({
                            "stb_sn": stb_sn[0],
                            "name": name[0],
                            "update_time": update_time[0],
                            "type": type[0],
                            "url": file_url[0]
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