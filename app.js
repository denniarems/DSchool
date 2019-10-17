let createError = require('http-errors');
let express = require('express');
let path = require('path');
let cookieParser = require('cookie-parser');
let logger = require('morgan');
let bodyParser = require('body-parser')

/*-------------------WEB3 Connection starts---------------------*/
let MyContractJSON = require(path.join(
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
DS = new web3.eth.Contract(contractAbi, contractAddress);
/*-------------------WEB3 Connection Ends----------------------*/

let indexRouter = require('./routes/index');
let StudentRouter = require('./routes/Student');
let EvaluatorRouter = require('./routes/Evaluator');

let app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/Student', StudentRouter);
app.use('/Evaluator', EvaluatorRouter);


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
