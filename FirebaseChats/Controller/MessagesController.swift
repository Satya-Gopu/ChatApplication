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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewMessage))
        self.isuserLoggedIn()
    }
    
   @objc func handleNewMessage(){
        let newMessageController = NewMessageController()
        present(UINavigationController(rootViewController : newMessageController), animated: true, completion: nil)
    }
    
    func isuserLoggedIn(){
        if let userid = Auth.auth().currentUser?.uid{
            self.updateNavigationBarTitle(userid : userid)
        }
        else{
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    func updateNavigationBarTitle(userid : String){
        Database.database().reference().child("users").child(userid).observeSingleEvent(of: .value, with: {
            (snapshot) in
            guard let user_dictionary = snapshot.value as? [String: Any] else{
                return
            }
            DispatchQueue.main.async {
                self.navigationItem.setTitleView(title: user_dictionary["name"] as? String, imageURL : user_dictionary["profileImageUrl"] as? String)
            }
        }, withCancel: { (error) in
            print(error.localizedDescription)
            return
        })
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
        }catch let error{
            print(error.localizedDescription)
        }
        
        let loginController = LoginViewController()
        loginController.messageController = self
        present(loginController, animated: true, completion: nil)
    }
}

extension UINavigationItem{
    
    func setTitleView(title : String?, imageURL : String?){
        guard let title = title, let url = imageURL else {
            return
        }
        let stackView = UIStackView()
        stackView.alignment = UIStackViewAlignment.center
        stackView.distribution = .equalCentering
        stackView.clipsToBounds = true
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.loadImageFromURL(urlString: url)
        stackView.addArrangedSubview(imageView)
        let attributes = [NSAttributedStringKey.font : UIFont(name: "Chalkduster", size: 17.0) as Any]
        let atributeString = NSAttributedString(string: title, attributes: attributes)
        let label = UILabel()
        label.attributedText = atributeString
        stackView.addArrangedSubview(label)
        self.titleView = stackView
    }
}

