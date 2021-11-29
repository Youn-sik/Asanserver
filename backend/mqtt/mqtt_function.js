const fs = require('fs');
const path = require('path');
const site_info_json = fs.readFileSync(path.join(__dirname, "../cloud44.json"));
const site = JSON.parse(site_info_json);
const client = require('./mqtt_load');
const Stopwatch = require('statman-stopwatch');
const stopwatch = new Stopwatch();

let moment = require('moment');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");

const db = require('../db');
const { devNull } = require('os');
const e = require('express');
const { stripVTControlCharacters } = require('util');

db.connect(err=> { //DB 실행
    if(err) {
      console.error(err);
      return;
    } 
    console.log('mysql connected as id ' + db.threadId);
}); 

db.on('error', err=> {
    console.log(err.message);
});

const preventClosingConnection= ()=>{
    try{ db.query('SELECT 1') }
    catch (e) {console.error(e)}
}
const intervalId= setInterval(preventClosingConnection, 5* 1000);

module.exports = {

    async login(json){
        try {
            let stb_sn = json.stb_sn;
            let result;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');

            db.query('select * from g_stb where main_stb_sn = ?', stb_sn , (err,stb)=> {
                if(err) console.log(err);
                // console.log(stb)
                if(stb.length != 0){
                    db.query('update g_stb set update_time = ?, network_status = ? where main_stb_sn = ?', [time, 'Y', stb_sn], (error)=> {
                        if(error) console.log(error)
                    })

                    result = {
                        "stb_sn": stb[0].main_stb_sn,
                        "result": "ok",
                        "value": {
                            "value1": "value1",
                            "value2": "value2",
                        }
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                    }
                }
                client.publish('/login/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })
            });
        } catch(err) {
            console.log(err)
        }
    },

    async logout(json){
        try {
            let stb_sn = json.stb_sn;
            let result;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            db.query('select * from g_stb where main_stb_sn = ?', stb_sn , (err,stb)=> {
                if(err) console.log(err);
                if(stb.length != 0){
                    db.query('update g_stb set update_time = ?, network_status = ? where main_stb_sn = ?', [time, 'N', stb_sn], (error)=> {
                        if(error) console.log(error)
                    })
                    result = {
                        "stb_sn": stb[0].main_stb_sn,
                        "result": "ok",
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                    }
                }
                client.publish('/logout/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })
            });
        } catch(err) {
            console.log(err)
        }
    },

    async disconnet(json){
        try {
            let stb_sn = json.stb_sn;
            let result;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            db.query('select * from g_stb where main_stb_sn = ?', stb_sn, (err, stb)=> {
                if(err) console.log(err)
                if(stb.length != 0){
                    db.query('update g_stb set update_time = ?, network_status = ? where main_stb_sn = ?', [time, 'N', stb_sn], (error)=> {
                        if(error) console.log(error)
                    })
                }
            })
/*
            if(stb != null){
                result = {
                    "stb_sn": stb.main_serial_number,
                    "result": "ok",
                }
            } else {
                result = {
                    "stb_sn": stb_sn,
                    "result": "fail",
                }
            }
            client.publish('' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                if(err) console.log(err);
            })
*/
        } catch(err) {
            console.log(err)
        }
    },

    async sync_stb(json){
        try {
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result;
            db.query('select * from g_stb where main_stb_sn = ?', stb_sn, (err, stb)=> {
                if(err) console.log(err);
                if(stb.length != 0){
                    result = {
                        "stb_sn": stb_sn,
                        "result": "ok",
                        "time": time,
                        "value": {
                            "main": stb[0].main_stb_sn,
                            "sub": stb[0].sub_stb_sn,
                        }
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                        "time": time,
                        "value": {
                            "main": '',
                            "sub": '',
                        }
                    }  
                }
                client.publish('/sync/stb/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   
            })
        }catch(err) {
            console.log(err)
        }
    },

    async schedule_total(json){
        try {
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result;
            //left join 또는 inner join 사용 => 사용 방식에 따라 result form 단말에게 맞추기.(이 함수에만 left join, inner join 구비 = 다른 곳은 다 inner join)
            db.query('select g_distribution.stb_sn as distribution_stb_sn, g_distribution.update_time as distribution_update_time , g_distribution.name as distribution_name,' + 
                     'g_schedule.name as schedule_name, g_schedule.update_time as schedule_update_time, g_schedule.order as schedule_order, g_schedule.start as schedule_start,' + 
                     'g_schedule.order as schedule_order, g_schedule.start as schedule_start, g_schedule.end as schedule_end, g_schedule.main_name as schedule_main, g_schedule.end as schedule_end,' + 
                     ' g_schedule.main_name as schedule_main, g_schedule.home_name as schedule_home, g_schedule.checklist_name as schedule_checklist, g_schedule.layout_name as schedule_layout,' +
                     ' g_schedule.media_name as schedule_media  from g_distribution inner join g_schedule on g_distribution.stb_sn = g_schedule.stb_sn where g_distribution.stb_sn = ?',
                     stb_sn, (err, stb)=> {
                // console.log(stb);
                if(err) console.log(err);
                // 스케줄이 여러개 일 때 텟하기
                if(stb.length != 0){
                    /*result = { //left join 일 때, 스케줄 비었을 때 null 로 출력 => '' 빈 값으로 출력 => 하단 result 등 
                        "stb_sn": stb[0].distribution_stb_sn != null ? stb[0].distribution_stb_sn : '',
                        "name": stb[0].distribution_name != null ? stb[0].distribution_name : '', 
                        "update_time": stb[0].distribution_update_time != null ? stb[0].distribution_update_time : '',
                        "result": stb[0].schedule_name != null ? 'ok' : 'fail',
                        "value": {
                            "scheduler":[{ // inner join 과 동일하게 for문과 함께 작업 필요
                                "name": stb[0].schedule_name != null ? stb[0].schedule_name : '',
                                "update_time": stb[0].schedule_update_time != null ? stb[0].schedule_update_time : '',
                                "order": stb[0].schedule_order != null ? stb[0].schedule_order : '',
                                "start": stb[0].schedule_start != null ? stb[0].schedule_start : '',
                                "end": stb[0].schedule_end != null ? stb[0].schedule_end : '',
                                "main": stb[0].schedule_main != null ? stb[0].schedule_main : '',
                                "home": stb[0].schedule_home != null ? stb[0].schedule_home : '',
                                "checklist": stb[0].schedule_checklist != null ? stb[0].schedule_checklist : '',
                                "layout": stb[0].schedule_layout != null ? stb[0].schedule_layout : '',
                                "media": stb[0].schedule_media != null ? stb[0].schedule_media : ''
                            }]
                        }
                    }*/
                    
                    let scheduler = [];
                    for(let i=0; i<stb.length; i++){
                        let schedule = new Object();
                        schedule.name = stb[i].schedule_name;
                        schedule.update_time = stb[i].schedule_update_time;
                        schedule.order = stb[i].schedule_order;
                        schedule.start = stb[i].schedule_start;
                        schedule.end = stb[i].schedule_end;
                        schedule.main = stb[i].schedule_main;
                        schedule.home = stb[i].schedule_home;
                        schedule.checklist = stb[i].schedule_checklist;
                        schedule.layout = stb[i].schedule_layout;
                        schedule.media = stb[i].schedule_media;
                        scheduler.push(schedule);
                    }
                    result = { //inner join 일 때, 스케줄 비었을 때 fail 로 출력 
                        "stb_sn": stb[0].distribution_stb_sn,
                        "name": stb[0].distribution_name, 
                        "update_time": stb[0].distribution_update_time,
                        "result": 'ok',
                        "value": {
                            "scheduler" : scheduler
                        }
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                        "value": {
                            "scheduler":[{}]
                        }
                    }
                }
                // console.log(JSON.stringify(result))
                client.publish('/schedule/total/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   
            })
        }catch(err) {
            console.log(err)
        }
    },

    async schedule_main(json){
        try {
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result;
            
            db.query('select g_main.stb_sn, g_main.name as main_name, g_main.update_time as main_update_time, g_surgery.name as list_name, '+
            'g_surgery.update_time as list_update_time, g_surgery.order as list_order, g_surgery.start as list_start, g_surgery.end as list_end '+
            'from g_main inner join g_surgery on g_main.order = g_surgery.g_main_home_order where g_main.stb_sn = ?', stb_sn, (err, stb)=> {
                // console.log(stb);
                if(err) console.log(err);
                if(stb.length != 0){

                    let main = [];
                    for(let i=0; i<stb.length; i++){
                        let main_list = new Object();
                        main_list.name = stb[i].list_name;
                        main_list.update_time = stb[i].list_update_time;
                        main_list.order = stb[i].list_order;
                        main_list.start = stb[i].list_start;
                        main_list.end = stb[i].list_end;
                        main.push(main_list);
                    }

                    result = { 
                        "stb_sn": stb[0].stb_sn,
                        "name": stb[0].main_name,
                        "update_time": stb[0].main_update_time,
                        "result": 'ok',
                        "value": main
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                        "value": [{
                            
                        }]
                    }
                }
                // console.log(JSON.stringify(result))
                client.publish('/schedule/main/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   
            })
        }catch(err) {
            console.log(err)
        }
    },

    async schedule_face(json){
        try {
            /*let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result;
            
            db.query('', (err, stb)=> {
                console.log(stb);
                if(err) console.log(err);
                if(stb.length != 0){

                    // let home = [];
                    // for(let i=0; i<stb.length; i++){
                    //     let home_list = new Object();
                    //     home_list.name = stb[i].list_name;
                    //     home_list.update_time = stb[i].list_update_time;
                    //     home_list.order = stb[i].list_order;
                    //     home_list.start = stb[i].list_start;
                    //     home_list.end = stb[i].list_end;
                    //     home.push(home_list);
                    // }

                    // result = { 
                    //     "stb_sn": stb[0].stb_sn,
                    //     "name": stb[0].home_name,
                    //     "update_time": stb[0].home_update_time,
                    //     "result": 'ok',
                    //     "value": home
                    // }
                } else {
                    // result = {
                    //     "stb_sn": stb_sn,
                    //     "result": "fail",
                    //     "value": [{
                            
                    //     }]
                    // }
                }
                // console.log(JSON.stringify(result))
                client.publish('/schedule/face/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   
            })*/
        }catch(err) {
            console.log(err)
        }
    },

    async schedule_home(json){
        try {
            let stb_sn = json.stb_sn;
            let home_name = json.name
            let time = moment().format('YYYY-MM-DD HH:mm:ss');

            let result = {};
            
            function first_query() {
                return new Promise((reslove, reject)=> {
                    db.query('select g_home.stb_sn, g_home.name, g_home.update_time, g_surgery.name as surgery_name,g_surgery.order as surgery_order, '+
                    'g_patient.id as patient_id, g_patient.name as patient_name, g_patient.gender as patient_gender, g_patient.age as patient_age, '+
                    'g_patient.dob as patient_dob, g_patient.surgicalsite as patient_surgicalsite from g_home inner join g_surgery '+
                    'on g_home.order = g_surgery.g_main_home_order inner join g_patient on g_surgery.order = g_patient.g_surgery_order '+
                    'where g_home.stb_sn = ? and g_home.name = ?', [stb_sn, home_name], (err, stb)=> {
                        // console.log(stb);
                        if(err) console.log(err);
                        if(stb.length != 0){
                        
                            let surgery_patient = new Object();
                            surgery_patient.stb_sn = stb[0].stb_sn; 
                            surgery_patient.name = stb[0].name; //홈 화면 이름
                            surgery_patient.update_time = stb[0].update_time; 
                            surgery_patient.surgery_name = stb[0].surgery_name; //수술 이름
                            surgery_patient.surgery_order = stb[0].surgery_order;  
                            surgery_patient.patient_id = stb[0].patient_id; 
                            surgery_patient.patient_name = stb[0].patient_name; 
                            surgery_patient.patient_gender = stb[0].patient_gender; 
                            surgery_patient.patient_age = stb[0].patient_age; 
                            surgery_patient.patient_dob = stb[0].patient_dob; 
                            surgery_patient.patient_surgicalsite = stb[0].patient_surgicalsite; 
                            surgery_patient.surgicalname = 

                            result = {
                                "stb_sn": surgery_patient.stb_sn,
                                "name": surgery_patient.name,
                                "update_time": surgery_patient.update_time,
                                "result": "ok",
                                "value": [{
                                    "staff": [{

                                    }],
                                    "patient": {
                                        "id": surgery_patient.patient_id,
                                        "name": surgery_patient.patient_name,
                                        "gender": surgery_patient.patient_gender,
                                        "age": surgery_patient.patient_age,
                                        "dob": surgery_patient.patient_dob,
                                        "surgicalsite": surgery_patient.patient_surgicalsite,
                                        "surgicalname": surgery_patient.surgery_name
                                    },
                                    "process": {
                                        
                                    },
                                }]
                            }
        
                            reslove(surgery_patient);
                        } else {
                            result = {
                                "stb_sn": stb_sn,
                                "name": home_name,
                                "result": "fail",
                                "value": [{
                                    
                                }]
                            }
                            reject(result);                      
                        }
                        
                    })
                });
            }

            function second_query(surgery_patient){
                return new Promise((reslove, reject)=>{
                    db.query('select g_staff.id as id, g_staff.name as name, g_staff.position as position  from g_home '+
                    'inner join g_surgery on g_home.order = g_surgery.g_main_home_order inner join g_staff on '+
                    'g_staff.g_surgery_order = g_surgery.order where g_staff.g_surgery_order = ?', 
                    surgery_patient.surgery_order, (err, stb)=> {
                        // console.log(stb);
                        if(err) console.log(err);
                        if(stb.length != 0){
                            result.value[0].staff = stb;
                            reslove(surgery_patient);
                        } else {
                            result = {
                                "stb_sn": stb_sn,
                                "name": home_name,
                                "result": "fail",
                                "value": [{
                                    
                                }]
                            }
                            reject(result)
                        }
                    })
                });
            }

            function third_query(surgery_patient){
                return new Promise((resolve, reject)=> {
                    db.query('select g_process.order as id, g_process_list.order as contents_seq, g_process_list.value as contents_value '+
                    'from g_process inner join g_process_list on g_process.order = g_process_list.process_order inner join g_surgery on '+
                    'g_surgery.order = g_process.g_surgery_order where g_process.g_surgery_order = ?', 
                    surgery_patient.surgery_order, (err, stb)=> {
                        // console.log(stb);
                        if(err) console.log(err);
                        if(stb.length != 0){
                            let process = [];
                            let process_id = stb[0].id;
                            for(let i = 0; i<stb.length; i++){
                                let process_list = new Object();
                                process_list.seq = stb[i].contents_seq;
                                process_list.value = stb[i].contents_value;
                                process.push(process_list);
                            }
                            result.value[0].process.id = process_id;
                            result.value[0].process.contents = process;
                            
                            resolve();
                        } else {
                            result = {
                                "stb_sn": stb_sn,
                                "name": home_name,
                                "result": "fail",
                                "value": [{
                                    
                                }]
                            }
                            reject(result)
                        }
                    })
                })
            }

            first_query()
            .then((surgery_patient)=> {
                // console.log('-----first query end-----')
                // console.log(JSON.stringify(result))
                return second_query(surgery_patient);
            }).then((surgery_patient)=> {
                // console.log('-----second query end-----')
                // console.log(JSON.stringify(result))
                return third_query(surgery_patient);
            }).then(()=> {
                // console.log('-----third query end-----')
                // console.log(JSON.stringify(result))

                client.publish('/schedule/home/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   

            }).catch((reject)=> {
                console.log(reject);
            })

        }catch(err) {
            console.log(err)
        }
    },

    async schedule_layout(json){
        try {
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result;

            db.query('select g_layout.stb_sn as stb_sn, g_layout.name, g_layout.update_time, g_layout_list_layout.name as layout_name, '+
            'g_layout_list_layout.update_time as layout_update_time, g_layout_list_layout.order as layout_list_order, g_layout_list_layout.imageurl, '+
            'g_layout_list_define.order as layout_define_order, g_layout_list_define.x, g_layout_list_define.y, g_layout_list_define.width, '+
            'g_layout_list_define.height, g_layout_list_define.contents from g_layout inner join g_layout_list_layout on '+
            'g_layout.order = g_layout_list_layout.g_layout_order inner join g_layout_list_define on g_layout.order = g_layout_list_define.order '+
            'where g_layout.stb_sn = ?', stb_sn, (err,stb)=> {
                // console.log(stb);
                if(err) console.log(err);
                if(stb.length != 0){

                    let list_layout = [];
                    let list_define = [];
                    for(let i=0; i<stb.length; i++){
                        let layout_list = new Object();
                        let define_list = new Object();
                        layout_list.name = stb[i].layout_name;
                        layout_list.update_time = stb[i].layout_update_time;
                        layout_list.order = stb[i].layout_list_order;
                        layout_list.imageurl = stb[i].imageurl;
                        define_list.order = stb[i].layout_define_order;
                        define_list.x = stb[i].x;
                        define_list.y = stb[i].y;
                        define_list.width = stb[i].width;
                        define_list.height = stb[i].height;
                        define_list.contents = stb[i].contents;
                        list_layout.push(layout_list);
                        list_define.push(define_list)
                    }
                    let layout = [];
                    layout = {
                        "layout": list_layout,
                        "define": list_define
                    }

                    result = { 
                        "stb_sn": stb[0].stb_sn,
                        "name": stb[0].name,
                        "update_time": stb[0].update_time,
                        "result": 'ok',
                        "value": layout
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                        "value": [{
                            
                        }]
                    }
                }
                // console.log(JSON.stringify(result))
                client.publish('/schedule/layout/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   
            })
        }catch(err) {
            console.log(err)
        }
    },

    async schedule_checklist(json){
        try {
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result;
            
            db.query('select g_checklist.stb_sn, g_checklist.name as checklist_name, g_checklist.order as checklist_order, '+
            'g_checklist.update_time as checklist_update_time, g_checklist_list.name as list_name, g_checklist_list.update_time as list_update_time, '+
            'g_checklist_list.value as list_value, g_checklist_list.order as list_order from g_checklist '+
            'inner join g_checklist_list on g_checklist.order = g_checklist_list.checklist_order where g_checklist.stb_sn = ?', stb_sn, (err, stb)=> {
                // console.log(stb);
                if(err) console.log(err);
                if(stb.length != 0){

                    let contents = [];
                    for(let i=0; i<stb.length; i++){
                        let contents_list = new Object();
                        contents_list.name = stb[i].list_name;
                        contents_list.value = stb[i].list_value;
                        contents.push(contents_list);
                    }
                    
                    result = { 
                        "stb_sn": stb[0].stb_sn,
                        "name": stb[0].checklist_name,
                        "update_time": stb[0].checklist_update_time,
                        "result": 'ok',
                        "value": {
                            "id": stb[0].checklist_order,
                            contents
                        }
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                        "value": [{
                            
                        }]
                    }
                }
                // console.log(JSON.stringify(result))
                client.publish('/schedule/checklist/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   
            })
        }catch(err) {
            console.log(err)
        }
    },

    async schedule_media(json){
        try {
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result;
            
            db.query('select g_media.stb_sn, g_media.name as media_name, g_media.update_time as media_update_time, g_media_list.name as list_name, '+
            'g_media_list.update_time as list_update_time, g_media_list.order as list_order '+
            'from g_media inner join g_media_list on g_media.order = g_media_list.g_media_order where g_media.stb_sn = ?', stb_sn, (err, stb)=> {
                // console.log(stb);
                if(err) console.log(err);
                if(stb.length != 0){

                    let media = [];
                    for(let i=0; i<stb.length; i++){
                        let media_list = new Object();
                        media_list.name = stb[i].list_name;
                        media_list.update_time = stb[i].list_update_time;
                        media_list.order = stb[i].list_order;
                        media_list.start = stb[i].list_start;
                        media_list.end = stb[i].list_end;
                        media.push(media_list);
                    }

                    result = { 
                        "stb_sn": stb[0].stb_sn,
                        "name": stb[0].media_name,
                        "update_time": stb[0].media_update_time,
                        "result": 'ok',
                        "value": media
                    }
                } else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail",
                        "value": [{
                            
                        }]
                    }
                }
                // console.log(JSON.stringify(result))
                client.publish('/schedule/media/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })   
            })
        }catch(err) {
            console.log(err)
        }
    },

/*
    async user_name_find (json) {
        try {
            let name = json.name;
            await User.findOne({"name":name}, (err, user)=>{
                if(err) console.log(err);
                else {
                    if(user) {
                        console.log(user.name, "의 data는", user.data, "입니다.")
                    }
                    else {
                        console.log("존재하지 않는 계정(사람) 입니다.")
                    }
                }
            })
        }catch(err) {
            console.log(err)
        }
    },
*/

    async operation_time_start(json) {
        try {
            let context = json;
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result = {};
            if(context.auth == 'cho'){
                if(context.stat == 'start'){
                    stopwatch.start();
                    result = {
                        "stb_sn": stb_sn,
                        "result": "ok",
                        "start_time": time
                    }
                    client.publish('/operation/start/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                        if(err) console.log(err);
                    })  
                }else {
                    result = {
                        "stb_sn": stb_sn,
                        "result": "fail"
                    }
                    client.publish('/operation/start/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                        if(err) console.log(err);
                    })  
                }
            }else {
                result = {
                    "stb_sn": stb_sn,
                    "result": "fail"
                }
                client.publish('/operation/start/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })  
            }
        }catch(err) {
            console.log(err)
        }
    },

    async operation_time_end(json) {
        try {
            let context = json;
            let stb_sn = json.stb_sn;
            let time = moment().format('YYYY-MM-DD HH:mm:ss');
            let result = {};
            if(context.auth == 'cho'){
                if(context.stat == 'end') {
                    stopwatch.stop();
                    let mil = Math.round(stopwatch.read());
                    let sec = ((mil/1000)%60).toFixed(1); //소수점 한 자릿수 출력[toFixed(1) 사용] 또는 정수만 출력[ | 0 사용]
                    let min = ((mil/(1000*60))%60) | 0;
                    let hou = ((mil/(1000*60*60))%24) | 0;

                    result = {
                        "stb_sn": stb_sn,
                        "result": "ok",
                        "end_time": time,
                        "time": hou+"h "+min+"m "+sec+"s"
                    }
                    client.publish('/operation/end/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                        if(err) console.log(err);
                    }) 
                    stopwatch.reset()
                }else {
                    result = {
                    "stb_sn": stb_sn,
                    "result": "fail"
                }
                client.publish('/operation/end/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })  
                }
            }else {
                result = {
                    "stb_sn": stb_sn,
                    "result": "fail"
                }
                client.publish('/operation/end/result/' + stb_sn, JSON.stringify(result), {qos:0, retain:false}, (err)=> {
                    if(err) console.log(err);
                })  
            }
        }catch(err) {
            console.log(err)
        }
    },

}