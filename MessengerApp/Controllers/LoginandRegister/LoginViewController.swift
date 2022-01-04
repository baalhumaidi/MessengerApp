//
//  ViewController.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
 

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //MARK: Login Process
    @IBAction func LoginButtonPressed(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty,
              password.count >= 6
        else{
            alertErrorLogin("error","Please enter the email address and password and password should be equal or more than 6 characters")
            return
        }
        
        // MARK: firebase auth and login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { AuthResult , Error in
            //guard let strongself = self else{return }
            guard let result = AuthResult, Error == nil else {
                self.alertErrorLogin("error", "there is an error in logging in")
                print ("error Logging In user")
                
                return }
            let user = result.user
            DispatchQueue.main.async {
                
                //self.alertErrorLogin("congratulations", "Logged In")
                print("Logged in \(user)")
                // not dismissing the page?
                
                self.dismiss(animated: true, completion:  nil)
            }
        }
        
    }
    

    func  alertErrorLogin(_ title: String,_ Msesage: String){
        let alert = UIAlertController (title: title, message: Msesage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Log In"
       // emailField.delegate = self
      //  passwordField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(Registernewaccount))
      

    }
 
    @objc private func Registernewaccount(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
           LoginButtonPressed(Any?.self)
//            LoginButton(Any?.self)
        }
        
        return true
    }
}
