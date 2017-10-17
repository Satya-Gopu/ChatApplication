//
//  LoginViewController.swift
//  FirebaseChats
//
//  Created by Satya on 10/16/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let inputContainerView : UIView = {
        let inputContainerView = UIView()
        inputContainerView.backgroundColor = UIColor.white
        inputContainerView.layer.cornerRadius = 5
        inputContainerView.translatesAutoresizingMaskIntoConstraints = false
        return inputContainerView
        }()
    let loginRegisterButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(red: 80, green: 101, blue: 161)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:61, green: 91, blue: 151)
        self.view.addSubview(inputContainerView)
        self.view.addSubview(loginRegisterButton)
        
        setupContainerView()
        setupLoginRegisterButton()
    }
    
    func setupContainerView(){
        //set the constraints for the container view: x, y, width, height
        NSLayoutConstraint.activate([
            inputContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            inputContainerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            inputContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24),
            inputContainerView.heightAnchor.constraint(equalToConstant: 150)])
        
    }
    
    func setupLoginRegisterButton(){
        NSLayoutConstraint.activate([loginRegisterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        loginRegisterButton.widthAnchor.constraint(equalTo: self.inputContainerView.widthAnchor),
        loginRegisterButton.topAnchor.constraint(equalTo: self.inputContainerView.bottomAnchor, constant: 12),
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 45)])
        
    }

}

extension UIColor{
    convenience init(red : CGFloat, green: CGFloat, blue : CGFloat){
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    
}
