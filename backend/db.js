const mysql = require('mysql');
const connection = mysql.createConnection({
  host: '172.16.41.233',
  port: '3306',
  user: 'asan',
  password: 'master123',
  database: 'asancloud',
  socketPath: '/var/run/mysqld/mysqld.sock'
});

module.exports = connection;