//
//  RegisterViewController.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import UIKit
import SwiftUI
import FirebaseAuth

class RegisterViewController: UIViewController {
        
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    //MARK: Register Process
    
    
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
        DataBaseManager.shared.userExists(with: email) { [weak self] exists  in
            guard let strongself = self else {return}
            guard !exists else {
                strongself.alertErrorLogin("error", "The email Address is already exist")
                print("user Already Exist")
                return
            }
      
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { AuthResult , Error in
           
            guard let result = AuthResult, Error == nil else {
                strongself.alertErrorLogin("error", "error creating user")
                print ("error creating user")
                return }
           
            DataBaseManager.shared.insertUser(with: userData(firstname: Fname, lastname: Lname, emailaddress: email))
            strongself.navigationController?.dismiss(animated: true, completion:  nil)

         //   strongself.navigationController?.popViewController(animated: false )

           
        }
        
        }
        
       // firebase auth and to create new account
        
    }
    func  alertErrorLogin(_ title: String,_ Msesage: String){
        let alert = UIAlertController (title: title, message: Msesage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)

    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
            super.viewDidLoad()
           title = "Create Account"
            // Do any additional setup after loading the view.
        profilePic.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ChangeProfilePic))
        profilePic.addGestureRecognizer(gesture)
        }
    override func viewDidLayoutSubviews() {
        profilePic.layer.masksToBounds = true
        profilePic.layer.borderWidth = 2
        profilePic.layer.borderColor = UIColor.gray.cgColor
        profilePic.layer.cornerRadius = profilePic.width/2 // to make the profile pic circular
        profilePic.contentMode = .scaleAspectFill
    }
    
    func setupFields(){
        
        
        
    }
   @objc func ChangeProfilePic(){
       choosingdifferentway()
        
    }

}


//MARK: Picking the profile Picture
extension RegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func choosingdifferentway(){
        let ActionSheet = UIAlertController (title: "Profile Picture", message: "How would you Like to select profile Picture", preferredStyle: .actionSheet)
        ActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        ActionSheet.addAction(UIAlertAction(title: "Take Photo ", style: .default, handler: {[weak self] _ in
            self?.presentCamera()   }   ))
        ActionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: {  [weak self] _ in
            self?.presentPhotoPicker() }  ))
        present(ActionSheet, animated: true, completion: nil)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
        
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        else {return}
        profilePic.image = selectedImage
//        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
//        else {return }
//        self.profilePic.image = selectedImage

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
}
