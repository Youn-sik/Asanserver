const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();
const db = require('./db.js'); // db 불러오기
const route = require('./route.js');
const meditation = require('./routes/v2/meditation');
const stb = require('./routes/v3/stb');
const schedule = require('./routes/v3/schedule');
const port = 3000;

db.connect(); // 실행
db.on('error', err=> {
  console.log(err.message);
});

app.use(function(req, res, next){
  res.header("Access-Control-Allow-Origin", "*");
  next();
});
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json())

app.use('/layout', express.static('upload/layout/')) 
app.use('/layout_used', express.static('upload/layout_used/'))

app.use('/uploads', express.static('uploads/'))

app.use('/meditation', meditation);
app.use('/stb', stb);
app.use('/schedule', schedule);

app.use('/', route);

app.listen(port, ()=>{
  console.log(`backend app listening on port ${port}`);
})
