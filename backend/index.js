const express = require('express');
const path = require('path');
const app = express();
const db = require('./server.js'); // db 불러오기
const route = require('./route.js');
const port = 3000;

db(); // 실행

app.use('/', route);
app.listen(port, ()=>{
  console.log(`backend app listening on port ${port}`);
})
