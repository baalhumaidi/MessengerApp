//
//  ProfileViewController.swift
//  MessengerApp
//
//  Created by administrator on 03/01/2022.
//

import UIKit
import FirebaseAuth



class ProfileViewController: UIViewController {
    
    
    let data = ["Log out"]
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "profile "
        myTableView.dataSource = self
        myTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
}


extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "SingleCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // unhighlight the cell
        // logout the user
        
        // show alert
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            // action that is fired once selected
            
            guard let strongSelf = self else {
                return
            }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                // present login view controller
                let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                //navigationController?.pushViewController(nav, animated: true)
                strongSelf.tabBarController?.present(nav, animated: true, completion: nil)
            }
            catch {
                print("failed to logout")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
}

extension ProfileViewController{
    
    
    
}


class MyTabBarController: UITabBarController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(" we are in Tab bar ")
        self.selectedIndex = 0
    }
}
