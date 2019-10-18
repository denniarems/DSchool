let express = require('express');
let router = express.Router();
const signTxn = require('./signTx');

router.get('/Student/get', function (req, res, next) {
    res.send('We Dont Work in That Way! Go Back And Click Student Corner');
});
router.post('/set', function (req, res, next) {
    data = req.body;

    let publicAddress = data.pubkey;
    let privateKey = data.privkey;
    let methodCall = DS.methods.setStudent(
        data.name,
        data.age
    );

    signTxn.sendTransaction(methodCall, publicAddress, privateKey, response => {
        response ? res.send('Student Registered') : res.send('Transaction failed');
    });
});
router.get('/get', function (req, res, next) {
    data = req.query;
    DS.methods.getStudent()
        .call({ from: data.pubkey }).then((val) => {
            console.log(val);
            res.render('pages/index', { myData: val });
        })
});

router.post('/task', function (req, res, next) {
    data = req.body;
    console.log(data);

    let publicAddress = data.pubkey;
    let privateKey = data.privkey;
    let methodCall = DS.methods.taskSubmission(
        data.name,
        data.skill
    );

    signTxn.sendTransaction(methodCall, publicAddress, privateKey, response => {
        response ? res.send('Task Submited Successfully') : res.send('Transaction failed');
    });
});
module.exports = router;