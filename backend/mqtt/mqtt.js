const client = require('./mqtt_load')
const fn = require('./mqtt_function');


let moment = require('moment');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");
// moment().format('YYYY-MM-DD HH:mm:ss');

client.on('connect', () => {
    console.log('Connected')
    client.subscribe([
        '/operation/start/+',
        '/operation/start/result/+',
        '/operation/end/+',
        '/operation/end/result/+',
        '/login/+',
        '/login/result/+',
        '/logout/+',
        '/logout/result/+',
        '/disconnect/result/+',
        '/sync/stb/+',
        '/sync/stb/result/+',
        '/schedule/total/+',
        '/schedule/total/result/+',
        '/schedule/main/+',
        '/schedule/main/result/+',
        '/schedule/face/+',
        '/schedule/face/result/+',
        '/schedule/home/+',
        '/schedule/home/result/+',
        '/schedule/layout/+',
        '/schedule/layout/result/+',
        '/schedule/checklist/+',
        '/schedule/checklist/result/+',
        '/schedule/media/+',
        '/schedule/media/result/+',
    ], (err, result) => {
        if(err) console.log('MQTT subscribe error.');
        else console.log('MQTT subscribed.');
    })

    // setInterval(function() { //10분마다 on / off 를 확인한다.
    //     fn.chk_status();
    // }, 10 * 60 * 1000);

    // client.publish('/operation/start/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205", "auth": "cho", "stat":"start"}), {qos:0, retain:false}, (error)=> {
    //     if(error){
    //         console.error(error);
    //     }
    // })
    
    // setTimeout(()=> {
    //     client.publish('/operation/end/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205", "auth": "cho", "stat":"end"}), {qos:0, retain:false}, (error)=> {
    //         if(error){
    //             console.error(error);
    //         }
    //     })
    // }, 14651) 

    // client.publish('/qqq', JSON.stringify({"name":"조윤식"}), {qos:0, retain:false}, (error) => {
    //     if(error){
    //         console.error(error);
    //     }
    // })

    // client.publish('/qqq', JSON.stringify({"name":"조상인"}), {qos:0, retain:false}, (error) => {
    //     if(error){
    //         console.error(error);
    //     }
    // })

    //==========================

    // client.publish('/login/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    // client.publish('/logout/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    // client.publish('/disconnect/result/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    // client.publish('/sync/stb/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205"}),{qos: 0, retain: false}, (err)=> {
    //     if(err) console.log(err);
    // })

    // client.publish('/schedule/total/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    // client.publish('/schedule/main/KSQ19880206', JSON.stringify({"stb_sn": "KSQ19880206"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    client.publish('/schedule/face/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205"}), {qos: 0, retain: false}), (err)=> {
        if(err) console.log(err);
    }

    // client.publish('/schedule/home/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205", "name": "first home"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    // client.publish('/schedule/layout/KSQ19880207', JSON.stringify({"stb_sn": "KSQ19880207"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    // client.publish('/schedule/checklist/KSQ19880206', JSON.stringify({"stb_sn": "KSQ19880206"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

    // client.publish('/schedule/media/KSQ19880205', JSON.stringify({"stb_sn": "KSQ19880205"}), {qos: 0, retain: false}), (err)=> {
    //     if(err) console.log(err);
    // }

})

client.on('message', async (topic, payload) => {
    console.log('----', topic, '----')
    console.log(moment().format('YYYY-MM-DD HH:mm:ss'))
    try{
        let context = payload.toString();
        let json = JSON.parse(context);
        console.log(json);

        //수술 시작
        if(topic == '/operation/start/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.operation_time_start(json)
            }
        }

     
        //수술 종료
        if(topic == '/operation/end/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.operation_time_end(json)
            }
        }

        // //로그인
        if(topic == '/login/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.login(json)
            }
        }

        // //로그아웃
        if(topic == '/logout/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.logout(json)
            }
        }

        // //서버 접속종료
        if(topic == '/disconnect/result/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.disconnet(json)
            }
        }

        //단말
        if(topic == '/sync/stb/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.sync_stb(json)
            }
        }

        //스케줄 전체
        if(topic == '/schedule/total/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.schedule_total(json)
            }
        }

        //대기화면
        if(topic == '/schedule/main/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.schedule_main(json)
            }
        }

        //얼굴 스캔
        if(topic == '/schedule/face/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.schedule_face(json)
            }
        }

        //홈화면
        if(topic == '/schedule/home/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.schedule_home(json)
            }
        }

        //레이아웃
        if(topic == '/schedule/layout/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.schedule_layout(json)
            }
        }

        //체크리스트
        if(topic == '/schedule/checklist/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.schedule_checklist(json)
            }
        }

        //미디어
        if(topic == '/schedule/media/' + json.stb_sn){
            if(json.stb_sn != undefined){
                fn.schedule_media(json)
            }
        }


        // if(topic == ''){
            
        // }


        // if(topic == ''){
            
        // }


        // if(topic == ''){
            
        // }


        // if(topic == ''){
            
        // }
    } catch (error) {
        console.log(error);
    }
    
})
