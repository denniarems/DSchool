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
router.get('/Tasks', async function (req, res, next) {
  try {
    const totaltask = await DS.methods.TotalTasks().call();
    console.log("Total Task", totaltask);
    let tasklist = [];
    for (let index = 0; index < totaltask; index++) {
      task = await DS.methods.viewAssignment(index).call();
      tasklist.push(task)
    }
    const validTask = tasklist.filter(task => task._valid)
    const nonValidTask = tasklist.filter(task => !task._valid)

    res.render('pages/tasks', { validTask, nonValidTask });
  } catch (error) {
    console.log(error);
  }
});

module.exports = router;
