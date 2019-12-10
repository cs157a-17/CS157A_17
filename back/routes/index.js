var express = require('express');
var router = express.Router();
var db = require('../controllers/connector/mysql_conn');

//Home Page
router.get('/', checkauthorization, function(req, res, next) {
  var sql = 'SELECT * FROM items';
  var sql1 =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('home', { items: result2, itemincart: result1[0].iic });
    });
  });
});

//Page
router.get('/men', checkauthorization, function(req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'MEN'";
  var sql1 =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {
        titlename: 'Men',
        name: "MEN'S APPAREL",
        items: result2,
        itemincart: result1[0].iic
      });
    });
  });
});

router.get('/women', checkauthorization, function(req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'WOMEN'";
  var sql1 =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {
        titlename: 'Women',
        name: "WOMEN'S APPAREL",
        items: result2,
        itemincart: result1[0].iic
      });
    });
  });
});

router.get('/books', checkauthorization, function(req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'BOOK'";
  var sql1 =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {
        titlename: 'Books',
        name: 'BOOKS',
        items: result2,
        itemincart: result1[0].iic
      });
    });
  });
});

router.get('/stationery', checkauthorization, function(req, res, next) {
  var sql = "SELECT * FROM items WHERE Category = 'STATIONERY'";
  var sql1 =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {
        titlename: 'Stationery',
        name: 'STATIONERY',
        items: result2,
        itemincart: result1[0].iic
      });
    });
  });
});

//Profile
router.get('/profile', checkauthorization, function(req, res, next) {
  var sql = "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +req.session.userId +"'";

  db.query(sql, function(error, results, fields) {
    res.render('profile', {user: req.session.user, itemincart: results[0].iic});
  });
});

router.post('/profile', checkauthorization, function(req, res, next) {
  if (req.body.password != req.body.password_confirm) {
    res.redirect('/editprofile');
  } else {
    var sql2 = "UPDATE users SET Password = '" + req.body.password + "', PhoneNumber = '" + req.body.phonenumber + "' WHERE UserID = '" + req.session.userId + "'" ;
    var sql = "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +req.session.userId +"'";
    var sql3 = "SELECT * FROM users WHERE UserID = '"+req.session.userId+"'";

    db.query(sql2, function(error, result, fields) {
      db.query(sql, function(error, results, fields) {
        db.query(sql3, function(error, result2, fields) {
          req.session.user = result2[0];
          res.redirect('profile');
        });
      });
    });
  }
});

router.get('/editprofile', checkauthorization, function(req, res, next) {
  console.log(req.session);
  var sql =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql, function(error, results, fields) {
    res.render('editprofile', {
      user: req.session.user,
      itemincart: results[0].iic
    });
  });
});

//Add to cart button
router.get('/addtocart/:id', function(req, res, next) {
  var sql = "SELECT Price FROM items WHERE ItemID = '" + req.params.id + "'";

  db.query(sql, function(error, result1, fields) {
    var sql1 =
      "SELECT * FROM carts WHERE UserID = '" +
      req.session.userId +
      "' AND ItemID = '" +
      req.params.id +
      "'";

    db.query(sql1, function(error, result2, fields) {
      if (result2.length > 0) {
        var temp1 = result2[0].Quantity + 1,
          temp2 = result2[0].TotalPrice + result1[0].Price;
        var sql3 =
          "UPDATE carts SET Quantity='" +
          temp1 +
          "', TotalPrice='" +
          temp2 +
          "' WHERE UserID='" +
          req.session.userId +
          "' AND ItemID='" +
          req.params.id +
          "'";

        db.query(sql3, function(error, result3, fields) {
          res.redirect('back');
        });
      } else {
        var sql2 =
          "INSERT INTO carts VALUES ('" +
          req.session.userId +
          "', '" +
          req.params.id +
          "', 1, '" +
          result1[0].Price +
          "')";

        db.query(sql2, function(error, result3, fields) {
          res.redirect('back');
        });
      }
    });
  });
});

//Cart
router.get('/cart', checkauthorization, function(req, res, next) {
  var sql =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";
  var sql1 =
    "SELECT items.ItemID, Name, Price, Category, Quantity, TotalPrice FROM items, carts WHERE UserID = '" +
    req.session.userId +
    "' AND items.ItemID = carts.ItemID";
  var sql2 =
    "SELECT SUM(TotalPrice) as total FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql, function(error, result, fields) {
    db.query(sql1, function(error, results, fields) {
      db.query(sql2, function(error, result2, fields) {
        req.session.total = result2[0].total;
        res.render('cart', {
          user: req.session.UserID,
          itemincart: result[0].iic,
          items: results,
          total: req.session.total
        });
      });
    });
  });
});

//cart button decrease
router.get('/dec/:id', checkauthorization, function(req, res, next) {
  var sql = "SELECT Price FROM items WHERE ItemID = '" + req.params.id + "'";
  var sql1 =
    "SELECT items.ItemID, Name, Price, Category, Quantity, TotalPrice FROM items, carts WHERE carts.ItemID = '" +
    req.params.id +
    "' AND UserID = '" +
    req.session.userId +
    "' AND items.ItemID = carts.ItemID";

  db.query(sql, function(error, result, fields) {
    db.query(sql1, function(error, result1, fields) {
      if (result1[0].Quantity > 1) {
        var temp1 = result1[0].Quantity - 1,
          temp2 = result1[0].TotalPrice - result[0].Price;
        var sql2 =
          "UPDATE carts SET Quantity='" +
          temp1 +
          "', TotalPrice='" +
          temp2 +
          "' WHERE UserID='" +
          req.session.userId +
          "' AND ItemID='" +
          req.params.id +
          "'";

        db.query(sql2, function(error, result2, fields) {
          res.redirect('back');
        });
      } else {
        var sql2 =
          "DELETE FROM carts WHERE UserID='" +
          req.session.userId +
          "' AND ItemID='" +
          req.params.id +
          "'";

        db.query(sql2, function(error, result2, fields) {
          res.redirect('back');
        });
      }
    });
  });
});

//cart button increase
router.get('/inc/:id', checkauthorization, function(req, res, next) {
  var sql = "SELECT Price FROM items WHERE ItemID = '" + req.params.id + "'";
  var sql1 =
    "SELECT items.ItemID, Name, Price, Category, Quantity, TotalPrice FROM items, carts WHERE carts.ItemID = '" +
    req.params.id +
    "' AND UserID = '" +
    req.session.userId +
    "' AND items.ItemID = carts.ItemID";

  db.query(sql, function(error, result, fields) {
    db.query(sql1, function(error, result1, fields) {
      var temp1 = result1[0].Quantity + 1,
        temp2 = result1[0].TotalPrice + result[0].Price;
      var sql2 =
        "UPDATE carts SET Quantity='" +
        temp1 +
        "', TotalPrice='" +
        temp2 +
        "' WHERE UserID='" +
        req.session.userId +
        "' AND ItemID='" +
        req.params.id +
        "'";

      db.query(sql2, function(error, result2, fields) {
        res.redirect('back');
      });
    });
  });
});

//checkout
router.get('/checkout', checkauthorization, checktotal, function (req, res, next) {
  var sql = "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" + req.session.userId + "'";

  db.query(sql, function (error, results, fields) {
    req.session.total = req.session.total;
    res.render('checkout', { user: req.session.UserID, itemincart: results[0].iic, total: req.session.total });
  });
});

//post checkout
router.post('/checkoutform', checkauthorization, checktotal, function(
  req,
  res,
  next
) {
  var sql = "SELECT * FROM addresses WHERE Street = '" + req.body.street + "'";
  var sql2 =
    "SELECT * FROM payingusers WHERE CardNumber = '" +
    req.body.cardnumber +
    "'";
  var sql4 = "DELETE FROM carts WHERE UserID = '" + req.session.userId + "'";

  db.query(sql4, function(error, result, fields) {});
  db.query(sql, function(error, result, fields) {
    if (result.length) {
      db.query(sql2, function(error, result2, fields) {
        if (result2.length) {
          res.redirect('success');
        } else {
          var temp2 = req.body.expirationY + '-' + req.body.expirationM;
          db.query(
            "INSERT INTO payingusers VALUES ('" +
              req.body.cardnumber +
              "', '" +
              req.body.cardholder +
              "', '" +
              temp2 +
              "', '" +
              req.body.card +
              "')",
            function(error, results, fields) {
              res.redirect('success');
            }
          );
        }
      });
    } else {
      var sql3 =
        'SELECT AddressID as aid FROM addresses ORDER BY AddressID DESC LIMIT 1';
      db.query(sql3, function(error, result3, fields) {
        var temp = result3[0].aid + 1;
        var temp2 = req.body.expirationY + '-' + req.body.expirationM;
        var sqlad =
          "INSERT INTO addresses VALUES ('" +
          temp +
          "','" +
          req.body.street +
          "','" +
          req.body.city +
          "','" +
          req.body.state +
          "','" +
          req.body.zip +
          "')";
        var sqlpu =
          "INSERT INTO payingusers VALUES ('" +
          req.body.cardnumber +
          "','" +
          req.body.cardholder +
          "','" +
          temp2 +
          "','" +
          req.body.card +
          "')";
        db.query(sqlad, function(error, results, fields) {
          db.query(sqlpu, function(error, results, fields) {
            res.redirect('success');
          });
        });
      });
    }
  });
});

//success
router.get('/success', checkauthorization, checktotal, function (req, res, next) {
  var sql = "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" + req.session.userId + "'";

  db.query(sql, function (error, results, fields) {
    temp = req.session.total + 3.9;
    req.session.total = 0;
    res.render('success', {user: req.session.UserID, itemincart: results[0].iic, total: temp});
  });
});

//search
router.get('/search', checkauthorization, function (req, res, next) {
  res.redirect('/');
});

//post search
router.post('/search', checkauthorization, function(req, res, next) {
  var sql = "SELECT * FROM items WHERE Name LIKE '%" + req.body.search + "%'";
  var sql1 =
    "SELECT SUM(Quantity) as iic FROM carts WHERE UserID = '" +
    req.session.userId +
    "'";

  db.query(sql1, function(error, result1, fields) {
    db.query(sql, function(error, result2, fields) {
      res.render('page', {
        titlename: 'Search',
        name: 'Result for ' + req.body.search,
        items: result2,
        itemincart: result1[0].iic
      });
    });
  });
});

//Registration
router.get('/registration', checkunauthorization, function(req, res, next) {
  res.render('registration');
});

router.post('/signup', checkunauthorization, function(req, res, next) {
  var users = {
    UserID: req.body.userid,
    FirstName: req.body.firstname,
    LastName: req.body.lastname,
    Password: req.body.password,
    PhoneNumber: req.body.phonenumber
  };
  var sql = "SELECT * FROM users WHERE UserID = '" + users.UserID + "'";

  db.query(sql, function(error, results, fields) {
    if (results.length) {
      res.render('registration', { message: 'User ID already exists!' });
    } else {
      db.query('INSERT INTO users SET ?', users, function(
        error,
        results,
        fields
      ) {
        res.render('landing', {
          message: 'Succesfully! Your account has been created.'
        });
      });
    }
  });
});

//Log In
router.get('/landing', checkunauthorization, function(req, res, next) {
  res.render('landing');
});

router.post('/login', checkunauthorization, function(req, res, next) {
  var userid = req.body.userid;
  var pass = req.body.password;
  var sql = "SELECT * FROM users WHERE UserID ='" + userid +"' and Password = '" +pass +"'";

  db.query(sql, function(err, results) {
    if (results.length) {
      req.session.userId = results[0].UserID;
      req.session.user = results[0];
      res.redirect('/');
    } else {
      res.render('landing', { message: 'Wrong Credentials' });
    }
  });
});

//Log out
router.get('/logout', checkauthorization, function(req, res, next) {
  req.session.destroy(function(err) {
    res.redirect('landing');
  });
});

//Mics
function checkauthorization(req, res, next) {
  if (req.session.userId == null) {
    res.redirect('landing');
  } else {
    next();
  }
}

function checkunauthorization(req, res, next) {
  if (req.session.userId != null) {
    res.redirect('/');
  } else {
    next();
  }
}

function checktotal(req, res, next) {
  if (req.session.total > 0) {
    next();
  } else {
    res.redirect('/');
  }
}

module.exports = router;
