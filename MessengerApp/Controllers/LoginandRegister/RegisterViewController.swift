//
//  RegisterViewController.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import UIKit

class RegisterViewController: UIViewController {
        
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func RegiserButton(_ sender: UIButton) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let Fname = firstName.text, let Lname = lastName.text, let email = emailField.text, let password = passwordField.text,
              !Fname.isEmpty,!Lname.isEmpty,
              !email.isEmpty, !password.isEmpty,
        password.count >= 6
        else{
                 alertErrorLogin("error","Please enter all information and password should be equal or more than 6 characters to create a new account")
                  return
              }
        
       // firebase auth and to create new account
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    func  alertErrorLogin(_ title: String,_ Msesage: String){
        let alert = UIAlertController (title: title, message: Msesage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)

    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
           title = "Create Account"
            // Do any additional setup after loading the view.
        profilePic.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ChangeProfilePic))
        profilePic.addGestureRecognizer(gesture)
        }
    
    func setupFields(){
        
    }
   @objc func ChangeProfilePic(){
       print("Change the PIC")
        
    }

}
