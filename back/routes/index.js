var express = require('express');
var router = express.Router();
var db = require('../controllers/connector/mysql_conn');

/* GET home page. */
router.get('/', checkauthorization, function (req, res, next) {
  res.render('home');
});

//Page
router.get('/registration', checkunauthorization, function (req, res, next) {
  res.render('registration');
});

router.post('/signup', checkunauthorization, function (req, res, next) {
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
      res.render('registration', {message: "User ID already exists!"});
    } else {
      db.query('INSERT INTO users SET ?',users, function (error, results, fields) {
        res.render('landing', {message: "Succesfully! Your account has been created."});
      });
    }
  });
});

router.get('/landing', checkunauthorization, function (req, res, next) {
  res.render('landing');
});

router.post('/login', checkunauthorization, function (req, res, next) {
  var userid = req.body.userid;
  var pass = req.body.password;
  var sql = "SELECT * FROM users WHERE UserID ='"+userid+"' and Password = '"+pass+"'";       

  db.query(sql, function(err, results){     
    if (results.length) {
      req.session.userId = results[0].UserID;
      req.session.user = results[0];
      res.redirect('/');
    } else {
      res.render('landing', {message: 'Wrong Credentials'});
    }     
  }); 
});

router.get('/profile', checkauthorization, function (req, res, next) {
  res.render('profile', {user: req.session.user});  
});

router.get('/logout', function (req, res, next) {
  req.session.destroy(function(err) {
    res.redirect('landing');
  })
});

function checkauthorization(req, res, next){
  if (req.session.userId == null) {
    res.redirect('landing');
  } else {
    next();
  }
};

function checkunauthorization(req, res, next){
  if (req.session.userId != null) {
    res.redirect('/');
  } else {
    next();
  }
};

module.exports = router;
