const mqtt = require('mqtt');
const fn = require('./mqtt_function');

const host = 'broker.emqx.io'
const port = '1883'
const clientId = `mqtt_${Math.random().toString(16).slice(3)}`
const connectUrl = `mqtt://${host}:${port}`

const client = mqtt.connect(connectUrl, {
    clientId,
    clean: true,
    connectTimeout: 4000,
    username: 'emqx',
    password: 'public',
    reconnectPeriod: 1000,
})

client.on('connect', () => {
    console.log('Connected')
    client.subscribe([
        '/qqq'
    ], (err, result) => {
        if(err) console.log('MQTT subscribe error.');
        else console.log('MQTT subscribed.')
    })
    
    client.publish('/qqq', JSON.stringify({"name":"조윤식"}), {qos:0, retain:false}, (error) => {
        if(error){
            console.error(error);
        }
    })
})

client.on('message', async (topic, payload) => {
    console.log('----', topic, '----')
    if(topic == '/qqq'){
        let context = payload.toString();
        let json = JSON.parse(context);
        console.log('json: ', json)
        fn.user_name_find(json);
    }
})
