const express = require('express');
const router = express.Router();
const db = require('../../db');

let moment = require('moment');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");

db.on('error', err=> {
    console.log(err.message);
});

router.get('/', async(req, res) =>{
    try{
        let result = {};

        db.query('select * from g_stb', (err,stb)=> {
            if(err) console.log(err);
            // console.log(stb);
            if(stb.length != 0){
                let stb_arr = [];

                for(let i=0; i<stb.length; i++){
                    let stb_obj = new Object();
                    stb_obj.uid = stb[i].uid;
                    stb_obj.main_stb_sn = stb[i].main_stb_sn;
                    stb_obj.sub_stb_sn = stb[i].sub_stb_sn;
                    stb_obj.update_time = stb[i].update_time.toISOString().slice(0, 19).replace('T', ' ');
                    stb_obj.network_status = stb[i].network_status;
                    stb_arr.push(stb_obj);
                }
                
                result = {
                    result: "ok",
                    values: stb_arr
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