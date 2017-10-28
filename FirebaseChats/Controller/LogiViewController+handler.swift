//
//  LogiViewController+handler.swift
//  FirebaseChats
//
//  Created by Satya on 10/18/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension LoginViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func performLogin(){
        guard let email = emailTextField.text, let password = passwordTextField.text else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                print("Something went wrong")
                return
            }
            guard let userid = user?.uid else{
                return
            }
            DispatchQueue.main.async {
                self.messageController.updateNavigationBarTitle(userid: userid)
                self.messageController.observUserMessages()
                self.dismiss(animated: true, completion: nil)
            }
         })
    }
    func performRegister(){
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else{
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil{
                print(error?.localizedDescription ?? "error occured while registering")
                return
            }
            guard let uid = user?.uid else{
                return
            }
            let storageRef = Storage.storage().reference()
            let fileRef = storageRef.child("profile_images").child(name + "-" + uid)
            guard let image = self.profileImageView.image else{
                return
            }
            guard let imageData = UIImageJPEGRepresentation(image, 0.1) else{
                return
            }
            fileRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                guard let imageURL = metaData?.downloadURL()?.absoluteString else{
                    return
                }
                imageCache.setObject(image, forKey: imageURL as AnyObject)
                self.storeUserData(uid: uid, values: ["name": name, "email": email, "profileImageUrl": imageURL])
            })
        })
    }
    
    func storeUserData(uid: String, values: [String: Any]){
        let ref = Database.database().reference().child("users").child(uid)
        ref.updateChildValues(values, withCompletionBlock: {
            (error, ref) in
            if error != nil{
                print("can not save user data")
                return
            }
            DispatchQueue.main.async {
                let height = self.messageController.navigationController?.navigationBar.frame.height
                self.messageController.navigationItem.setTitleView(title: values["name"] as? String, imageURL: values["profileImageUrl"] as? String, navigationBarHeight: height)
                self.messageController.observUserMessages()
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    
    @objc func imageViewSelected(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate  = self
        self.presentAlert(picker : picker)
    }
    
    func presentAlert(picker : UIImagePickerController){
        let alert = UIAlertController(title: "select a source", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let action = UIAlertAction(title: "Launch Camera", style: .default, handler: { _ in
                self.launchCamera(picker : picker)
            })
            alert.addAction(action)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let action2 = UIAlertAction(title: "Pick a photo from the Library", style: .default, handler: { _ in
                self.findInLibrary(picker : picker)
            })
            alert.addAction(action2)
        }
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
                alert.dismiss(animated: true, completion: nil)
            })
        alert.addAction(action3)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func launchCamera(picker : UIImagePickerController){
        picker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func findInLibrary(picker : UIImagePickerController){
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            self.profileImageView.image = editedImage
        }else{
            self.profileImageView.image = info["UIImagePickerControllerOriginalImage"] as? UIImage
            
        }
        dismiss(animated: true, completion: nil)
    }
}
