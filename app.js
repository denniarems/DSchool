var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var address;
/*-------------------WEB3 Connection starts---------------------*/
var MyContractJSON = require(path.join(
  __dirname,
  'build/contracts/DSchool.json'
));
const Web3 = require('web3');
web3 = new Web3(
  new Web3.providers.HttpProvider(
    'http://127.0.0.1:8545'
  )
);
contractAddress = MyContractJSON.networks['5777'].address;
const contractAbi = MyContractJSON.abi;
SMS = new web3.eth.Contract(contractAbi, contractAddress);
/*-------------------WEB3 Connection Ends----------------------*/

var indexRouter = require('./routes/index');
var setStudentRouter = require('./routes/setStudent');
var getStudentRouter = require('./routes/getStudent');
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
// app.use('/setStudent', setStudentRouter);
// app.use('/getStudent', getStudentRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('pages/error');
});

module.exports = app;
