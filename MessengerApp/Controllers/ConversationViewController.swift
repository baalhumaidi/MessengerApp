//
//  ConversationViewController.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import UIKit

class ConversationViewController: UIViewController {


    class ConversationsViewController: UIViewController {
        // check to see if user is signed in using ... user defaults
        // they are, stay on the screen. If not, show the login screen
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
            if !isLoggedIn {
                // present login view controller
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: false)// false // to make the delay between this page and the login page is less
                
            }
        }
    }


}
