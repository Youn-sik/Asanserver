{
    "base_url": "http://127.0.0.1/",
    "base_server_document": "~/asan/backend",
    "base_local_url": "http://172.16.41.233",
    "local_url": "127.0.0.1",

    "mongodb_host": "127.0.0.1",
    "mongodb_user": "kool",
    "mongodb_passwd": "master",
    "mongodb_database": "cloud40",

    "mqtt_host": "127.0.0.1",
    "mqtt_user": "",
    "mqtt_passwd": "",
    "mqtt_port": "1883"
}as id ' + db.threadId);
}); 

db.on('error', err=> {
  console.log(err.message);
})

const preventClosingConnection= ()=>{
  try{ db.query('SELECT 1') }
  catch (e) {console.error(e)}
}
const intervalId= setInterval(preventClosingConnection, 5* 1000);

app.listen(port, ()=>{
  console.log(`backend app listening on port ${port}`);
})


//Router
const userRouter = require('./routes/v1/user');
const accountRouter = require('./routes/v1/account')

//router
app.use(bodyParser.json());
// app.use('', router);
app.use('/user', userRouter);
app.use('/account', accountRouter);

app.use('/layout', express.static("/home/asan/asan/backend/upload/layout"));
app.use('/movie', express.static("/home/asan/asan/backend/upload/movie"));
app.use('/music', express.static("/home/asan/asan/backend/upload/music"));
