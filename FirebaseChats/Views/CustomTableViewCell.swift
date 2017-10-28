//
//  CustomTableViewCell.swift
//  FirebaseChats
//
//  Created by Satya on 10/24/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import UIKit
import Firebase

class UserCell : UITableViewCell{
    
    var message : Message?{
        didSet{
            var otherUser : String?
            if Auth.auth().currentUser?.uid == message?.senderId{
                otherUser = message?.receiverId
            }
            else{
                otherUser = message?.senderId
            }
            if let userid = otherUser{
                Database.database().reference().child("users").child(userid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let userdict = snapshot.value as? [String: Any]{
                        DispatchQueue.main.async {
                            self.textLabel?.text = userdict["name"] as? String
                            self.detailTextLabel?.text = self.message?.content
                            if let timestamp = self.message?.timestamp{
                                let doubleStamp = Double(timestamp)
                                let dateformatter = DateFormatter()
                                dateformatter.dateFormat = "MM/dd/yy hh:mm a"
                                self.timeLabel.text = dateformatter.string(from: Date(timeIntervalSince1970: doubleStamp))
                            }
                            if let profileImageUrl = userdict["profileImageUrl"] as? String{
                                self.profileImageView.loadImageFromURL(urlString: profileImageUrl)
                            }
                        }
                    }
                }, withCancel: { (error) in
                    self.textLabel?.text = self.message?.receiverId
                })
            }
         }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 70, y: (textLabel?.frame.origin.y)! - 2.0, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 70, y: detailTextLabel!.frame.origin.y + 2.0, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
        
    }
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profileImage")
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.addSubview(profileImageView)
        self.addSubview(timeLabel)
        //setup profile Imageview
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48.0).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        //setup timelabel
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4.0).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14.0).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: self.textLabel!.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
