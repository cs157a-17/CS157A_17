var express = require('express');
var router = express.Router();
var db = require('../controllers/connector/mysql_conn');

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index');
});

//Page
router.get('/signupform', function (req, res, next) {
  res.render('signupform');
});

router.get('/loginform', function (req, res, next) {
  res.render('loginform');
});

router.post('/signup', function (req, res, next) {
  var users = {
    "UserID":req.body.userid,
    "FirstName":req.body.firstname,
    "LastName":req.body.lastname,
    "Password":req.body.password,
    "PhoneNumber":req.body.phonenumber,
  }

  db.query('SELECT * FROM users WHERE `UserID` = ?', [req.body.userid], function (error, results, fields) {
    if (results.length > 0) {
      res.render('signupform', {message: "User ID already exists!"});
    } else {
      db.query('INSERT INTO users SET ?',users, function (error, results, fields) {
        if (error) {
          res.render('signupform');
        } else {
          res.render('profile', {name: req.body.firstname});
        }
      });
    }
  });

});

router.post('/login', function (req, res, next) {
  db.query('SELECT * FROM users WHERE `UserID` = ?',[req.body.userid], function (error, results, fields) {
    if (results.length > 0) {
      if (results[0].Password == req.body.password) {
        user = results[0];
        res.render('profile', {user: user});
      } else {
        res.render('loginform', {message: "Password is wrong!"});
      }
    } else {
      res.render('loginform', {message: "User ID does not exist!"});
    }
  });
});

module.exports = router;
