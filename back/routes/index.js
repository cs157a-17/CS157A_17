var express = require('express');
var router = express.Router();
var db = require('../controllers/connector/mysql_conn');

//Home Page
router.get('/', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items";
  var sql1 = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('home', {items: result2, itemincart: result1[0].iic});
    });
  });
});

//Page
router.get('/men', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'MEN'";
  var sql1 = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {titlename: 'Men', name: 'MEN\'S APPAREL', items: result2, itemincart: result1[0].iic});
    });
  });
});

router.get('/women', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'WOMEN'";
  var sql1 = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {titlename: 'Women', name: 'WOMEN\'S APPAREL', items: result2, itemincart: result1[0].iic});
    });
  });
});

router.get('/books', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'BOOK'";
  var sql1 = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {titlename: 'Books', name: 'BOOKS', items: result2, itemincart: result1[0].iic});
    });
  });
});

router.get('/stationery', checkauthorization, function (req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'STATIONERY'";
  var sql1 = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {titlename: 'Stationery', name: 'STATIONERY', items: result2, itemincart: result1[0].iic});
    });
  });
});

//Profile
router.get('/profile', checkauthorization, function (req, res, next) {
  var sql = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql, function(error, results, fields) {
    res.render('profile', {user: req.session.user, itemincart: results[0].iic});
  });
});

//Add to cart button
router.get('/addtocart/:id', function (req, res, next) {
  var sql = "SELECT Price FROM items WHERE ItemID = '"+req.params.id+"'";
  
  db.query(sql, function (error, results, fields) {
    var sql1 = "INSERT INTO carts VALUES ('"+req.session.userId+"', '"+req.params.id+"', 1, '"+results[0].Price+"')";
    db.query(sql1, function (error, result, fields) {
      res.redirect('back');
    });
  });
});

//Cart
router.get('/cart', checkauthorization, function (req, res, next) {
  var sql = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";
  var sql1 = "SELECT Name, Price, Category, Quantity, TotalPrice FROM items, carts WHERE UserID = '"+req.session.userId+"' AND items.ItemID = carts.ItemID";

  db.query(sql, function(error, result, fields) {
    db.query(sql1, function(error, results, fields) {
      res.render('cart', {user: req.session.UserID, itemincart: result[0].iic, items: results});
    });
  });
});

//checkout
router.get('/checkout', checkauthorization, function (req, res, next) {
  var sql = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql, function(error, results, fields) {
    res.render('checkout', {user: req.session.UserID, itemincart: results[0].iic});
  });
});

//success
router.get('/success', checkauthorization, function (req, res, next) {
  var sql = "SELECT COUNT(*) as iic FROM carts WHERE UserID = '"+req.session.userId+"'";

  db.query(sql, function(error, results, fields) {
    res.render('success', {user: req.session.UserID, itemincart: results[0].iic});
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
router.get('/logout', checkauthorization, function (req, res, next) {
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
