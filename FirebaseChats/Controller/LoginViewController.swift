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
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:61, green: 91, blue: 151)
        //create container view for the input form
        self.view.addSubview(inputContainerView)
        setupContainerView()
    }
    
    func setupContainerView(){
        //set the constraints for the container view: x, y, width, height
        NSLayoutConstraint.activate([
            inputContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            inputContainerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            inputContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24),
            inputContainerView.heightAnchor.constraint(equalToConstant: 150)])
        
    }

}

extension UIColor{
    convenience init(red : CGFloat, green: CGFloat, blue : CGFloat){
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    
}
