//
//  LogiViewController+handler.swift
//  FirebaseChats
//
//  Created by Satya on 10/18/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
