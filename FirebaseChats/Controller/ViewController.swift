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
        //ref = Database.database().reference()
    }
    
    @objc func handleLogout(){
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }

    


}

