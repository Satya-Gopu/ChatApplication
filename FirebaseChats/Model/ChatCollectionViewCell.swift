//
//  ChatCollectionViewCell.swift
//  FirebaseChats
//
//  Created by Satya on 10/28/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    var textLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func adjustAllignment(allignment : String){
        if allignment == "right"{
            self.textLabel.textAlignment = .right
        }else{
            self.textLabel.textAlignment = .left
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
