const fs = require('fs');
const path = require('path');
const site_info_json = fs.readFileSync(path.join(__dirname, "./cloud44.json"));
const site = JSON.parse(site_info_json);

let moment = require('moment');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");

const mongoose = require('mongoose');
const mongodb = mongoose.connection;
mongodb.on('error', console.error);
mongodb.once('open', ()=>{
    console.log('mongodb open(mqtt_function)');
});

mongoose.connect('mongodb://kool:master@127.0.0.1:27017/cloud44', function(err) {
    if (err) {
        console.error(err);
    }
    console.log('mongodb connected');
});

const User = require('./schema/user');

module.exports = {

    async user_name_find (json) {
        let name = json.name;
        User.findOne({"name":name}, (err, user)=>{
            if(err) console.log(err);
            else {
                console.log("user_name:",user.name)
            }
        })
    }

}String();
        let json = JSON.parse(context);
        console.log('json: ', json)
        fn.user_name_find(json);
    }
})
