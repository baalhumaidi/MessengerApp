//
//  ConversationViewController.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import UIKit
import FirebaseAuth

import Firebase

class ConversationViewController: UIViewController {
 
    
        // check to see if user is signed in using ... user defaults
        // they are, stay on the screen. If not, show the login screen
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Conversation page"

            //validateAuth()
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
       //     validateAuth()
          //  let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")

        }
 
        private func validateAuth(){
            if FirebaseAuth.Auth.auth().currentUser == nil {
                // present login view controller
               let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
//                let nav = UINavigationController(rootViewController: vc)
//                nav.modalPresentationStyle = .fullScreen
//                navigationController?.pushViewController(vc, animated: false)
                
                
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
               //navigationController?.pushViewController(nav, animated: true)
               present(nav, animated: false)// false // to make the delay between this page and the login page is less
                
            }
             
        }

    }



