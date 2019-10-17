let express = require('express');
let router = express.Router();

/* GET home page. */
router.get('/', function (req, res, next) {
  let a = {
    _stdId: null,
    _name: null,
    _age: null
  }
  res.render('pages/index', { myData: a });
});
router.get('/evaluator', function (req, res, next) {
  let a = {
    _evaId: null,
    _name: null,
    _skill: null,
    _skillRank: null,
  }
  res.render('pages/evaluator', { myData: a });
});
router.get('/Tasks', function (req, res, next) {
  res.render('pages/tasks');
});

module.exports = router;
