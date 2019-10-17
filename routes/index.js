var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('pages/index');
});
router.get('/evaluator', function (req, res, next) {
  res.render('pages/evaluator');
});
router.get('/certificats', function (req, res, next) {
  res.render('pages/certificats');
});

module.exports = router;
