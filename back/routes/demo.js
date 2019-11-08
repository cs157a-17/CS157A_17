var express = require('express');
var router = express.Router();
var db = require('../controllers/connector/mysql_conn');

/* Demo. */
router.get('/', function(req, res) {
  db.query("SELECT * FROM users", function (err, result, fields) {
    if (err) throw err;
    res.send(result);
  });
});

module.exports = router;
