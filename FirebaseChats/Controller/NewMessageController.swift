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
        self.tableView.register(UserCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        fetchUsers()
    }
    
    func fetchUsers(){
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else{
                return
            }
            let user = User()
            user.email = dictionary["email"] as? String
            user.name = dictionary["name"] as? String
            self.users.append(user)
            print(self.users.count)
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
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
        var tableCell : UITableViewCell?
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier){
            tableCell = cell
        }else{
            tableCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellReuseIdentifier)
        }
        tableCell!.textLabel?.text = users[indexPath.row].name
        tableCell!.detailTextLabel?.text = users[indexPath.row].email
        return tableCell!
    }
}

class UserCell : UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


