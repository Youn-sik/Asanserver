const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const db = require('./db.js'); // db 불러오기
const route = require('./route.js');
const meditation = require('./routes/v2/meditation');
const distribution_schedule = require('./routes/v2/distribution_schedule');
const stb = require('./routes/v3/stb');
const main = require('./routes/v3/main');
const schedule = require('./routes/v3/schedule');
const port = 3000;

db.connect(); // 실행
db.on('error', err=> {
  console.log(err.message);
  if(err.code == 'PROTOCOL_CONNECTION_LOST'){
    db.connect();
  } else throw err;
});

app.use(
  cors({
    origin: "*"
  })
)

app.use(function(req, res, next){
  res.header("Access-Control-Allow-Origin", "*");
  next();
});
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json())

//파일 접근
app.use('/layout', express.static('upload/layout/')) 
app.use('/layout_used', express.static('upload/layout_used/'))
app.use('/uploads', express.static('uploads/'))

//스케줄 등록 - 데이터 POST 라우터 + 대기화면 CRUD 용 라우터
app.use('/distribution_schedule/register', distribution_schedule);
app.use('/meditation', meditation);

//스케줄 등록 - 데이터 GET 라우터 
app.use('/stb', stb);
app.use('/main', main);
app.use('/schedule', schedule);

app.use('/', route); 

app.listen(port, ()=>{
  console.log(`backend app listening on port ${port}`);
})
