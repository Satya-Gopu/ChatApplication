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
            self.dismiss(animated: true, completion: nil)
        })
        
        
    }
    func performRegister(){
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else{
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil{
                
                print("Invalid credentials")
                return
            }
            
            //Store profile image in the cloud storage
            guard let uid = user?.uid else{
                return
            }
            let storageRef = Storage.storage().reference()
            let fileRef = storageRef.child("profile_images").child(name + "-" + uid)
            guard let image = self.profileImageView.image else{
                return
            }
            guard let imageData = UIImagePNGRepresentation(image) else{
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
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    
    @objc func imageViewSelected(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate  = self
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
