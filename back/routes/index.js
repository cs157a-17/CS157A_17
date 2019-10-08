var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Spartan Market' });
});

/* GET user page. */
router.get('/signup', function(req, res, next) {
  res.render('signup');
});

// Add a new user  
router.post('/signup/submit', function (req, res, next) {
  console.log("Hello");
  res.redirect('/');
});

module.exports = router;
