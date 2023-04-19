'use strict';
var express = require('express');
var app = express();

/*=requisição, resposta=*/

app.get('/', function(req,res){
    console.log('In nodejs base route EN');
    res.send('Hello World, welcome!');
});

/*=====*/

app.get('/pt', function(req,res,next){
    console.log("In nodejs route PT");
    res.send('Olá Mundo, seja bem-vindo!');
});

/*=====*/

app.get('/de', function(req,res,next){
    console.log("In nodejs route DE");
    res.send('Hallo Welt, willkommen!!');
});

/*=Rota para monitoração de disponibilidade=*/

app.get('/healthz', function(req,res,next){
    console.log("In nodejs route OK");
    res.send('OK');
});

/*=====*/

app.listen(8080, function(){
    console.log('hello world app listening on port 8080');
});


module.exports=app;