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

        db.query('select g_main.stb_sn, g_main_list.uid, g_main_list.name, g_main_list.update_time, g_main_list.start, g_main_list.end, '+
        'g_main_list.user, g_main_list.file_path, g_main_list.file_name, g_main_list.file_ext, g_main_list.file_url from g_main_list '+
        'inner join g_main on g_main.order = g_main_list.g_main_order where g_main.stb_sn = ?', stb_sn, (err,main_list)=> {
            if(err) console.log(err);
            // console.log(main_list);
            if(main_list.length != 0){
                let main_list_arr = [];

                for(let i=0; i<main_list.length; i++){
                    let main_list_obj = new Object();
                    main_list_obj.uid = main_list[i].uid;
                    main_list_obj.stb_sn = main_list[i].stb_sn;
                    main_list_obj.name = main_list[i].name;
                    main_list_obj.update_time = main_list[i].update_time.toISOString().slice(0, 19).replace('T', ' ');
                    main_list_obj.start = main_list[i].start;
                    main_list_obj.end = main_list[i].end;
                    main_list_obj.user = main_list[i].user;
                    main_list_obj.file_path = main_list[i].file_path;
                    main_list_obj.file_name = main_list[i].file_name;
                    main_list_obj.file_ext = main_list[i].file_ext;
                    main_list_obj.file_url = main_list[i].file_url;
                    main_list_arr.push(main_list_obj);
                }
                // console.log(main_list_arr);
                
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

module.exports = router;