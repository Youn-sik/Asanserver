const express = require('express');
const path = require('path');
const app = express();
const db = require('./db.js'); // db 불러오기
const route = require('./route.js');
const port = 3000;

db.connect(); // 실행

app.use('/layout', express.static('upload/layout/')) 
app.use('/layout_used', express.static('upload/layout_used/'))

app.use('/uploads', express.static('uploads/'))
app.use('/', route);

app.listen(port, ()=>{
  console.log(`backend app listening on port ${port}`);
})
