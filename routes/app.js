var express = require('express');
var router = express.Router();
var DAL = require("../Server/DAL");




router.post('/Login', function(req, res){
    
    let _dal = new DAL();

    _dal.Login(req.body.username,req.body.password).then((response,error)=>{
        if(error)
         res.send("Theres was an error");

         res.send(JSON.stringify(response));
    }).catch(error=>{
        res.send(JSON.stringify(error));
    })
   // res.send(JSON.stringify(req.body));
  
 });

router.post('/Getparents', function(req, res){
    
    let _dal = new DAL();

    _dal.Getparents(req.body.memberid).then((response,error)=>{
        if(error)
         res.send("Theres was an error");

         res.send(JSON.stringify(response));
    }).catch(error=>{
        res.send(JSON.stringify(error));
    })
   // res.send(JSON.stringify(req.body));
  
 });


router.post('/Getgrandparents', function(req, res){
    
    let _dal = new DAL();

    _dal.Getgrandparents(req.body.memberid).then((response,error)=>{
        if(error)
         res.send("Theres was an error");

         res.send(JSON.stringify(response));
    }).catch(error=>{
        res.send(JSON.stringify(error));
    })
   // res.send(JSON.stringify(req.body));
  
 });
 
 router.post('/GetUnclesAndAunties', function(req, res){
    
    let _dal = new DAL();

    _dal.GetUnclesAndAunties(req.body.memberid).then((response,error)=>{
        if(error)
         res.send("Theres was an error");

         res.send(JSON.stringify(response));
    }).catch(error=>{
        res.send(JSON.stringify(error));
    })
   // res.send(JSON.stringify(req.body));
  
 });

 router.post('/Getsiblings', function(req, res){
    
    let _dal = new DAL();

    _dal.Getsiblings(req.body.memberid).then((response,error)=>{
        if(error)
         res.send("Theres was an error");

         res.send(JSON.stringify(response));
    }).catch(error=>{
        res.send(JSON.stringify(error));
    })
   // res.send(JSON.stringify(req.body));
  
 });

 router.post('/Register', function(req, res){
    
    let _dal = new DAL();

    _dal.Register(req.body).then((response,error)=>{
        if(error)
         res.send("Theres was an error");

         res.send(JSON.stringify(response));
    }).catch(error=>{
        res.send(JSON.stringify(error));
    })
   // res.send(JSON.stringify(req.body));
  
 });
 router.post('/GetMember', function(req, res){
    
    let _dal = new DAL();

    _dal.GetMember(req.body).then((response,error)=>{
        if(error)
         res.send("Theres was an error");

         res.send(JSON.stringify(response));
    }).catch(error=>{
        res.send(JSON.stringify(error));
    })
   // res.send(JSON.stringify(req.body));
  
 });


 

 module.exports = router;