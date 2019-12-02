var express = require('express');
var router = express.Router();
var db = require('../controllers/connector/mysql_conn');

//Home Page
router.get('/', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items";
  var sql1 = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('home', {items: result2, itemincart: result1});
    });
  });
});

//Page
router.get('/men', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'MEN'";

  db.query(sql, function(error, results, fields) {
    res.render('men', {items: results});
  });
});

router.get('/women', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'WOMEN'";

  db.query(sql, function(error, results, fields) {
    res.render('women', {items: results});
  });
});

router.get('/books', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'BOOK'";

  db.query(sql, function(error, results, fields) {
    res.render('books', {items: results});
  });
});

router.get('/stationery', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'STATIONERY'";

  db.query(sql, function(error, results, fields) {
    res.render('stationery', {items: results});
  }); 
});

//Profile

//Cart

//Add to cart button
router.get('/addtocart/:id', function (req, res, next) {
  var sql = "SELECT Price FROM items WHERE ItemID = '"+req.params.id+"'";
  
  db.query(sql, function (error, results, fields) {
    var sql1 = "INSERT INTO carts VALUES ('"+req.session.userId+"', '"+req.params.id+"', 1, '"+results[0].Price+"')";
    db.query(sql1, function (error, result, fields) {
      res.redirect('/');
    });
  });
});

//Registration
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
      db.query('INSERT INTO users SET ?', users, function (error, results, fields) {
        res.render('landing', {message: "Succesfully! Your account has been created."});
      });
    }
  });
});

//Log In
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

//Log out
router.get('/logout', function (req, res, next) {
  req.session.destroy(function(err) {
    res.redirect('landing');
  })
});

//Mics
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
