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
                let navigationbarHeight = self.navigationController?.navigationBar.frame.height
                self.navigationItem.setTitleView(title: user_dictionary["name"] as? String, imageURL : user_dictionary["profileImageUrl"] as? String, navigationBarHeight: navigationbarHeight)
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
    
    func setTitleView(title : String?, imageURL : String?, navigationBarHeight : CGFloat?){
        guard let title = title, let url = imageURL else {
            return
        }
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8.0
        
        
        let imageView = UIImageView()
        imageView.loadImageFromURL(urlString: url)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        if let imageheight  = navigationBarHeight{
            imageView.heightAnchor.constraint(equalToConstant: imageheight - 4.0).isActive = true
            imageView.layer.cornerRadius = (imageheight - 4.0)/2
        }
        else{
            imageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        }
        
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        stackView.addArrangedSubview(imageView)
        
        let attributes = [NSAttributedStringKey.font : UIFont(name: "Chalkduster", size: 17.0) as Any]
        let atributeString = NSAttributedString(string: title, attributes: attributes)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = atributeString
        stackView.addArrangedSubview(label)
        
        self.titleView = stackView
    }
}

