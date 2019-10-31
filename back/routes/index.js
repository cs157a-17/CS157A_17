var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
});

router.post('/signup', function (req, res, next) {
  res.redirect('/signup');
});

router.post('/login', function (req, res, next) {
  res.redirect('/login');
});

/* GET user page. */
router.get('/signup', function(req, res, next) {
  res.render('signup');
});

router.get('/login', function(req, res, next) {
  res.render('login');
});


module.exports = router;
