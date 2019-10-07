
const express = require('express');
const mysql = require('mysql');
const app = express();

//Create connection
const db = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "root",
    database: "cs157a"
})

app.get('/', function(req, resp) {

    db.connect(function(err) {
      db.query("SELECT * FROM emp", function (err, result, fields) {
          if (err) throw err;
          resp.json(result);
      });
    });
  });

  app.listen(4000, function() {
      console.log('Started');
  });