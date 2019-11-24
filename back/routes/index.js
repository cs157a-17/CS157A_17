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

router.post('/signup', function (req, res, next) {
  var users = {
    "UserID":req.body.userid,
    "FirstName":req.body.firstname,
    "LastName":req.body.lastname,
    "Password":req.body.password,
    "PhoneNumber":req.body.phonenumber,
  }
  var sql = "SELECT * FROM users WHERE UserID = '"+users.UserID+"'";

  db.query(sql, function (error, results, fields) {
    if (results.length) {
      res.render('signupform', {message: "User ID already exists!"});
    } else {
      db.query('INSERT INTO users SET ?',users, function (error, results, fields) {
        res.render('loginform', {message: "Succesfully! Your account has been created."});
      });
    }
  });
});

router.get('/loginform', function (req, res, next) {
  res.render('loginform');
});

router.post('/login', function (req, res, next) {
  var userid = req.body.userid;
  var pass = req.body.password;
  var sql = "SELECT * FROM users WHERE UserID ='"+userid+"' and Password = '"+pass+"'";       

  db.query(sql, function(err, results){     
    if (results.length) {
      req.session.userId = results[0].UserID;
      req.session.user = results[0];
      res.redirect('profile');
    } else {
      res.render('loginform', {message: 'Wrong Credentials'});
    }     
  }); 
});

router.get('/profile', function (req, res, next) {
  if (req.session.userId == null){
    res.redirect('loginform');
  }

  res.render('profile', {user: req.session.user});  
});

router.get('/logout', function (req, res, next) {
  req.session.destroy(function(err) {
    res.redirect('loginform');
  })
});

module.exports = router;
