//
//  ChatLogController.swift
//  FirebaseChats
//
//  Created by Satya on 10/22/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController : UICollectionViewController{
    var messagesTextField : UITextField!
    var databaseRef : DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor.white
        self.navigationItem.title = "Chats"
        setUpInputComponents()
    }
    
    func setUpInputComponents(){
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        //setup containerview
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let sendButton = UIButton(type: UIButtonType.system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        //setup button
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10.0).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let textField = UITextField()
        self.messagesTextField = textField
        messagesTextField.delegate = self
        textField.placeholder = "message...."
        textField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(textField)
        //setup textfield
        textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10.0).isActive = true
        textField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        //textField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let seperator = UIView()
        seperator.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(seperator)
        //setup seperator
        seperator.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        seperator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        seperator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0).isActive = true
        
        
    }
    
    @objc func sendButtonClicked(){
        let value = ["message": messagesTextField.text!, "name": "satya"] as [String: Any]
        databaseRef.child("messages").setValue(value)
        print("send clicked")
        
    }
}

extension ChatLogController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonClicked()
        return true
    }
}
