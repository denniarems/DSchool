let express = require('express');
let router = express.Router();
const signTxn = require('./signTx');

router.get('/Evaluator/get', function (req, res, next) {
    res.send('We Dont Work in That Way! Go Back And Click Evaluator');
});
router.post('/set', function (req, res, next) {
    data = req.body;

    let publicAddress = data.pubkey;
    let privateKey = data.privkey;
    let methodCall = DS.methods.setApprover(
        data.name,
        data.skill,
        data.rank
    );

    signTxn.sendTransaction(methodCall, publicAddress, privateKey, response => {
        response ? res.send('Evaluator Registered') : res.send('Transaction failed');
    });
});
router.get('/get', async function (req, res, next) {
    data = req.query;
    const val = await DS.methods.getApprover().call({ from: data.pubkey })
    res.render('pages/evaluator', { myData: val });
});
router.post('/vote', function (req, res, next) {
    data = req.body;
    console.log(data);

    let publicAddress = data.pubkey;
    let privateKey = data.privkey;
    let id = Number(data.id) - 1
    let methodCall = DS.methods.Upvoting(
        id
    );
    signTxn.sendTransaction(methodCall, publicAddress, privateKey, response => {
        response ? res.send('Task Verifed Successfully') : res.send('Transaction failed');
    });
});
module.exports = router;

// 0xA2A14853402317490dAE7ff70D0c0348629F4D1E