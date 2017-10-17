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
    let profileImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "profileImage")
        imageview.translatesAutoresizingMaskIntoConstraints = false
       return imageview
    }()
    let nameTextField : UITextField = {
       let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let nameSeperator : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailSeperator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:61, green: 91, blue: 151)
        self.view.addSubview(inputContainerView)
        self.view.addSubview(profileImageView)
        self.view.addSubview(loginRegisterButton)
        setupContainerView()
        setupProfileImageView()
        setupLoginRegisterButton()
    }
    
    func setupProfileImageView(){
        NSLayoutConstraint.activate([profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     profileImageView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -15),
                                     profileImageView.heightAnchor.constraint(equalToConstant: 150),
                                     profileImageView.widthAnchor.constraint(equalToConstant: 150)])
    }
    
    func setupContainerView(){
        //set the constraints for the container view: x, y, width, height
        NSLayoutConstraint.activate([inputContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     inputContainerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     inputContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24),
                                     inputContainerView.heightAnchor.constraint(equalToConstant: 150)])
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeperator)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSeperator)
        inputContainerView.addSubview(passwordTextField)
        
        //setup the name textfield constraints
        NSLayoutConstraint.activate([nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3),
                                     nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
                                     nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12)])
        //setup name seperator constraints
        NSLayoutConstraint.activate([nameSeperator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     nameSeperator.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor),
                                     nameSeperator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: -2),
                                     nameSeperator.heightAnchor.constraint(equalToConstant: 2)])
        //setup the email textfield constraints
        NSLayoutConstraint.activate([emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3),
                                     emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
                                     emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12)])
        //setup email seperator constraints
        NSLayoutConstraint.activate([emailSeperator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     emailSeperator.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor),
                                     emailSeperator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: -2),
                                     emailSeperator.heightAnchor.constraint(equalToConstant: 2)])
        
        //setup password field constraints
        NSLayoutConstraint.activate([passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3),
                                     passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
                                     passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12)])
        
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
