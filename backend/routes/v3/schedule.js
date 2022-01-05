const express = require('express');
const router = express.Router();
const db = require('../../db');

let moment = require('moment');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");

db.on('error', err=> {
    console.log(err.message);
});

router.get('/:stb_sn', async(req, res) =>{
    try{
        let result = {};
        let stb_sn = req.params.stb_sn;
        // console.log(stb_sn)

        db.query('select * from g_schedule where stb_sn = ?', stb_sn, (err,schedule)=> {
            if(err) console.log(err);
            // console.log(schedule);
            if(schedule.length != 0){
                let schedule_arr = [];

                for(let i=0; i<schedule.length; i++){
                    let schedule_obj = new Object();
                    schedule_obj.uid = schedule[i].uid;
                    schedule_obj.stb_sn = schedule[i].stb_sn;
                    schedule_obj.name = schedule[i].name;
                    schedule_obj.update_time = schedule[i].update_time.toISOString().slice(0, 19).replace('T', ' ');
                    schedule_obj.order = schedule[i].order;
                    schedule_obj.start = schedule[i].start;
                    schedule_obj.end = schedule[i].end;
                    schedule_obj.main_name = schedule[i].main_name;
                    schedule_obj.home_name = schedule[i].home_name;
                    schedule_obj.checklist_name = schedule[i].checklist_name;
                    schedule_obj.layout_name = schedule[i].layout_name;
                    schedule_obj.media_name = schedule[i].media_name;
                    schedule_arr.push(schedule_obj);
                }
                
                result = {
                    result: "ok",
                    values: schedule_arr
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

module.exports = router;