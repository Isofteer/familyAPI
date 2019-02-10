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

 
    Register(p) {
        
        const sql = "select * from SaveMember($1, $2, $3, $4, $5, $6, $7, $8, $9,$10,$11)";
        return new Promise( ( resolve, reject ) => {
            this.pool.query( sql,[p.firstname,p.surname,p.middlename,p.gender,p.dateofbirth,p.nationalid,p.phone,p.email,p.pictureid,p.username,p.password],
                ( err, rows ) => {
                if ( err )
                    return reject( err );  
                    
                this.pool.end();
                resolve( rows );


            } );
        } );
    }

    GetMember(p) {      
        const sql = "select * from tblfamilymembers where nationalid ='"+p.searchValue+"' or phone ='"+p.searchValue+"'";
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