const mqtt = require('mqtt');
const fs = require('fs');
const path = require('path');
const site_info_json = fs.readFileSync(path.join(__dirname, "../cloud44.json"));
const site = JSON.parse(site_info_json);
const host = '127.0.0.1';
const port = '1883';
const clientId = `mqtt_cho`
const connectUrl = `mqtt://${host}:${port}`

const client = mqtt.connect(connectUrl, {
    // clientId,
    clean: true,
    connectTimeout: 15000,
    username: 'koolsign',
    password: '62958055',
    reconnectPeriod: 5000,
})

client.on('error', (err)=> {
    console.log(err);
})

module.exports = client;