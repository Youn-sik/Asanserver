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
let time = moment().format('YYYY-MM-DD HH:mm:ss');

router.post('/', (req, res)=> {
    let result = {}
    console.log(req.body);
});


module.exports = router;