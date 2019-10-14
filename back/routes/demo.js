var express = require('express');
var router = express.Router();
const mysql = require('mysql');

//Create connection
const db = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "root",
    database: "cs157a"
})

db.connect()

/* Demo. */
router.get('/', function(req, res) {
  db.query("SELECT * FROM users", function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
});

module.exports = router;
