//
//  NewMessageController.swift
//  FirebaseChats
//
//  Created by Satya on 10/18/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    let cellReuseIdentifier = "cell"
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Message"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        fetchUsers()
    }
    
    func fetchUsers(){
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            guard let dictionary = snapshot.value as? [String : Any] else{
                return
            }
            let user = User()
            user.email = dictionary["email"] as? String
            user.name = dictionary["name"] as? String
            self.users.append(user)
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    @objc func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) ?? UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellReuseIdentifier)
        cell.textLabel?.text = "hello there!"
        return cell
    }
}


