//
//  ViewController.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
 

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty,
        password.count >= 6
        else{
           alertErrorLogin("error","Please enter the email address and password and password should be equal or more than 6 characters")
                  return
              }
        
       // firebase auth and login
    }
    

    func  alertErrorLogin(_ title: String,_ Msesage: String){
        let alert = UIAlertController (title: title, message: Msesage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Log In"
        emailField.delegate = self
        passwordField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(Registernewaccount))
      

    }
    override func viewDidLayoutSubviews() {
        setupFields()
    }
    //
    func setupFields(){
        emailField.leftView = UIView(frame:(CGRect(x: 5, y: 0, width: 10, height: 0)))
        passwordField.leftView = UIView(frame:(CGRect(x: 5, y: 0, width: 5, height: 0)))
      //  emailField.placeholder = "HIIII"
        
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
