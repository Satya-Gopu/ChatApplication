//
//  NavigationItem+Extension.swift
//  FirebaseChats
//
//  Created by Satya on 10/24/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit

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

