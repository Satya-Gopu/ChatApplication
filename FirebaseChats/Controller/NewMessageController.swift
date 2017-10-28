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
    var messageController : MessagesController!
    let cellReuseIdentifier = "cell"
    var users = [User]()
    lazy var executeBlock : () = {[weak self] in
        DispatchQueue.main.async{
            self!.tableView.reloadData()
        }
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Message"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        self.tableView.register(UserCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        fetchUsers()
    }
    
    func fetchUsers(){
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else{
                return
            }
            let user = User()
            user.id = snapshot.key
            user.email = dictionary["email"] as? String
            user.name = dictionary["name"] as? String
            user.profileImageUrl = dictionary["profileImageUrl"] as? String
            self.users.append(user)
            print(self.users.count)
            _ = self.executeBlock
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    @objc func dismissController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? UserCell
        tableCell!.textLabel?.text = users[indexPath.row].name
        tableCell!.detailTextLabel?.text = users[indexPath.row].email
        tableCell?.profileImageView.loadImageFromURL(urlString : users[indexPath.row].profileImageUrl)
        return tableCell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: {
            self.messageController.showChatLogController(user: self.users[indexPath.row])
        })
    }
}


