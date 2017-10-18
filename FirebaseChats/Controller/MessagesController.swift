//
//  ViewController.swift
//  FirebaseChats
//
//  Created by Satya on 10/16/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
       isuserLoggedIn()
    }
    
    func isuserLoggedIn(){
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else{
            guard let userid = Auth.auth().currentUser?.uid else{
                return
            }
            Database.database().reference().child("users").child(userid).observeSingleEvent(of: .value, with: {
                (snapshot) in
                print(snapshot)
            }, withCancel: { (error) in
                print(error.localizedDescription)
                return
            })
        }
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
        }catch let error{
            print(error)
        }
        
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }

    


}

