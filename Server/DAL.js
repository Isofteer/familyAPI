const pg = require("pg");
const config = require("../config");
class DAL {
    constructor(  ) {
        this.pool = new pg.Pool(config);  // passing config
    }
  
Login(username,password) {      
    const sql = "select * from tblfamilymembers where username = '"+username+"' and password = '"+password+"'" ;
    return new Promise( ( resolve, reject ) => {
        this.pool.query( sql,( err, rows ) => {
            if ( err )
                return reject( err );  
                
            this.pool.end();
            resolve( rows );


        } );
    } );
}

    Getparents(id) {
      
        const sql = "select * from getparents("+id+")";
        return new Promise( ( resolve, reject ) => {
            this.pool.query( sql,( err, rows ) => {
                if ( err )
                    return reject( err );  
                    
                this.pool.end();
                resolve( rows );


            } );
        } );
   }
   
    Getgrandparents(id) {
      
        const sql = "select * from getgrandparents("+id+");";
        return new Promise( ( resolve, reject ) => {
            this.pool.query( sql,( err, rows ) => {
                if ( err )
                    return reject( err );  
                    
                this.pool.end();
                resolve( rows );


            } );
        } );
   }
   
   Getsiblings(id) {
      
    const sql = "select * from Getsiblings("+id+");";
    return new Promise( ( resolve, reject ) => {
        this.pool.query( sql,( err, rows ) => {
            if ( err )
                return reject( err );  
                
            this.pool.end();
            resolve( rows );


        } );
    } );
}

GetUnclesAndAunties(id) {      
    const sql = "select * from getunclesandaunties("+id+");";
    return new Promise( ( resolve, reject ) => {
        this.pool.query( sql,( err, rows ) => {
            if ( err )
                return reject( err );  
                
            this.pool.end();
            resolve( rows );


        } );
    } );
}

 
    Register(id) {
        
        const sql = "select * from getgrandparents("+id+");";
        return new Promise( ( resolve, reject ) => {
            this.pool.query( sql,( err, rows ) => {
                if ( err )
                    return reject( err );  
                    
                this.pool.end();
                resolve( rows );


            } );
        } );
    }

    close() {
        return new Promise( ( resolve, reject ) => {
            this.connection.end( err => {
                if ( err )
                    return reject( err );
                resolve();
            } );
        } );
    }


}


module.exports = DAL;