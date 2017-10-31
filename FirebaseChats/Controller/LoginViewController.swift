//
//  LoginViewController.swift
//  FirebaseChats
//
//  Created by Satya on 10/16/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    var containerViewHeightConstraint : NSLayoutConstraint?
    var emailTextFieldHeightConstraint : NSLayoutConstraint?
    var passwordFieldHeightConstraint : NSLayoutConstraint?
    var nameFieldHeightConstraint : NSLayoutConstraint?
    var nameSeperatorHeightConstraint : NSLayoutConstraint?
    
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Login", "Register"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.tintColor = UIColor.white
        segmentControl.selectedSegmentIndex = 1
        segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        return segmentControl
    }()
    
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
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(userResponseGiven), for: .touchUpInside)
        return button
    }()
    lazy var profileImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "profileImage")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewSelected)))
        imageview.isUserInteractionEnabled = true
       return imageview
    }()
    
    lazy var nameTextField : UITextField = {
       let tf = UITextField()
        tf.placeholder = "Name"
        tf.returnKeyType = .next
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let nameSeperator : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var emailTextField : UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.returnKeyType = .next
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailSeperator : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220, green: 220, blue: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var passwordTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.delegate = self
        tf.isSecureTextEntry = true
        tf.returnKeyType = .go
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        self.view.backgroundColor = UIColor(red:61, green: 91, blue: 151)
        self.view.addSubview(inputContainerView)
        self.view.addSubview(profileImageView)
        self.view.addSubview(loginRegisterButton)
        self.view.addSubview(loginRegisterSegmentedControl)
        setupContainerView()
        setupLoginRegisterButton()
        setupSegmentControl()
        setupProfileImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isuserLoggedIn()
    }
    
    func isuserLoggedIn(){
        if Auth.auth().currentUser?.uid != nil{
            let nav = UINavigationController(rootViewController: MessagesController())
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    @objc func viewTapped(){
        self.view.endEditing(true)
    }
    
    func setupSegmentControl(){
        
        NSLayoutConstraint.activate([loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo:                            self.view.centerXAnchor),
                                     loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30), loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -10)])
        
        
    }
    
    @objc func segmentValueChanged(){
        let index = loginRegisterSegmentedControl.selectedSegmentIndex
        let title = loginRegisterSegmentedControl.titleForSegment(at: index)
        loginRegisterButton.setTitle(title, for: .normal)
        profileImageView.isHidden = (index == 0)
        emailTextFieldHeightConstraint?.isActive = false
        passwordFieldHeightConstraint?.isActive = false
        nameFieldHeightConstraint?.isActive = false
        containerViewHeightConstraint?.constant = (loginRegisterSegmentedControl.selectedSegmentIndex == 1) ? 150 : 100
        nameSeperatorHeightConstraint?.constant = (loginRegisterSegmentedControl.selectedSegmentIndex == 1) ? 2 : 0
        emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: (loginRegisterSegmentedControl.selectedSegmentIndex == 1) ? 1/3 : 1/2)
        passwordFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: (loginRegisterSegmentedControl.selectedSegmentIndex == 1) ? 1/3 : 1/2)
        nameFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: (loginRegisterSegmentedControl.selectedSegmentIndex == 1) ? 1/3 : 0)
        NSLayoutConstraint.activate([emailTextFieldHeightConstraint!, passwordFieldHeightConstraint!, nameFieldHeightConstraint!])
    }
    
    
    @objc func userResponseGiven(){
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 1{
            performRegister()
        }else{
            performLogin()
        }
    }
    
    func setupProfileImageView(){
        NSLayoutConstraint.activate([profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -10),
                                     profileImageView.heightAnchor.constraint(equalToConstant: 120),
                                     profileImageView.widthAnchor.constraint(equalToConstant: 120)])
    }
    
    func setupContainerView(){
        //set the constraints for the container view: x, y, width, height
        NSLayoutConstraint.activate([inputContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     inputContainerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     inputContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24)])
        containerViewHeightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        containerViewHeightConstraint?.isActive = true
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeperator)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSeperator)
        inputContainerView.addSubview(passwordTextField)
        
        //setup the name textfield constraints
        NSLayoutConstraint.activate([nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor),
                                     nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12)])
        nameFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        nameFieldHeightConstraint?.isActive = true
        //setup name seperator constraints
        NSLayoutConstraint.activate([nameSeperator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     nameSeperator.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor),
                                     nameSeperator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: -2)])
        nameSeperatorHeightConstraint = nameSeperator.heightAnchor.constraint(equalToConstant: 2)
        nameSeperatorHeightConstraint?.isActive = true
        //setup the email textfield constraints
        NSLayoutConstraint.activate([emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
                                     emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12)])
        emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightConstraint?.isActive = true
        //setup email seperator constraints
        NSLayoutConstraint.activate([emailSeperator.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     emailSeperator.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor),
                                     emailSeperator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: -2),
                                     emailSeperator.heightAnchor.constraint(equalToConstant: 2)])
        
        //setup password field constraints
        NSLayoutConstraint.activate([passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor),
                                     passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
                                     passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12)])
        passwordFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        passwordFieldHeightConstraint?.isActive = true
        
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
