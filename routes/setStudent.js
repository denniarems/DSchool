var express = require('express');
var router = express.Router();
const signTxn = require('./signTx');

router.post('/', function (req, res, next) {
    data = req.body;
    var publicAddress = data.publicAddr;
    var privateKey = data.privateKey;

    var methodCall = SMS.methods.setStudent(
        data.roll,
        data.name,
        data.age,
        JSON.parse(data.indian),
        data.gender
    );

    signTxn.sendTransaction(methodCall, publicAddress, privateKey, response => {
        response ? res.send('Student Registered') : res.send('Transaction failed');
    });
});

module.exports = router;