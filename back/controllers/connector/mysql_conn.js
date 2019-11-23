var mysql = require('mysql');

//Create connection
const db = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: 'password123',
  database: 'cs157a'
});

module.exports = db;
