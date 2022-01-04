//
//  UsersInfo.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import Foundation
import Firebase
//import Da
//import FirebaseDatabase
import FirebaseCore

// final so this class cant be inheritied
 class DataBaseManager{
    
    static let shared = DataBaseManager()
    //MARK:  the database reference doesnt work
 
  //  var ref: DatabaseReference!
     var database = Database.database().reference()
    
    

    
    
    
    
    
}


struct userData{
    let firstname : String
    let lastname : String
    let emailaddress : String
    // let profilepic : binary? or String? or URL ?
    var safeEmail: String {
        var safeEmail = emailaddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}


// MARK: - account management
extension DataBaseManager {
    
    // have a completion handler because the function to get data out of the database is asynchrounous so we need a completion block
   
    public func userExists(with email:String, completion: @escaping ((Bool) -> Void)) {
        // will return true if the user email does not exist
        
        // firebase allows you to observe value changes on any entry in your NoSQL database by specifying the child you want to observe for, and what type of observation you want
        // let's observe a single event (query the database once)
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        //
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            
            // snapshot has a value property that can be optional if it doesn't exist
            // to check if the e-mail is excited in database
            guard snapshot.value as? String != nil else {
                // otherwise... let's create the account
                completion(false)
                return
            }
 // if we are able to do this, that means the email exists already!
            
            completion(true) // the caller knows the email exists already
        }
    }
    public func insertUser(with user: userData){
        // pass data as a dictionary
        database.child(user.safeEmail).setValue(["firstname": user.firstname,
                                             "lastname": user.lastname])
//        create a function to fetch the data in database

    }
    

}

