var express = require('express');
const bodyParser = require("body-parser");

var app = express();

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });

app.listen(5000);
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

var BAL  = require('./routes/app');

app.use('/actions', BAL);



