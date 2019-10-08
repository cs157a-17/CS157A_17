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
router.get('/', function(req, resp) {
  db.query("SELECT * FROM emp", function (err, result, fields) {
    if (err) throw err;
      resp.json(result);
  });
});

module.exports = router;
