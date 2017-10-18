//
//  ViewController.swift
//  FirebaseChats
//
//  Created by Satya on 10/16/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        if Auth.auth().currentUser == nil{
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            //performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
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

