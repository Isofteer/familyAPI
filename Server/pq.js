const pg = require("pg");
const config = require("../config");

class  DAL {

    constructor (){
     this.pool = new pg.Pool(config);  // passing config
    }
    
    GetMembers (){
 
        //const sql = "select * from is_tblFamilyMembers";
        const sql = "select * from getgrandparents(21)";
        return new Promise( ( resolve, reject ) => {
            this.pool.query( sql,( err, rows ) => {
                if ( err )
                    return reject( err );  
                    
                this.pool.end();
                resolve( rows );


            } );
        } );
    }

    
    InsertMembers (){

    
 
        const sql = "INSERT INTO public.is_tblfamilymembers(vfirstname, vsurname, vmiddlename, vgender, ddateofbirth, vusername, vpassword) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
        return new Promise( ( resolve, reject ) => {
            this.pool.query( sql,[],( err, rows ) => {
                if ( err )
                    return reject( err );  
                    
                this.pool.end();
                resolve( rows );


            } );
        } );
    }
}

module.exports = DAL;