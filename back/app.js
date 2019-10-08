var createError = require('http-errors');
const express = require('express');
const mysql = require('mysql');
const path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const app = express();

var indexRouter = require('./routes/index');
var demoRouter = require('./routes/demo');

app.use('/', indexRouter);
app.use('/demo', demoRouter);

//Create connection
const db = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "root",
    database: "cs157a"
})

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;