//
//  Message.swift
//  FirebaseChats
//
//  Created by Satya on 10/24/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import Foundation
import Firebase

struct Message{
    var content : String?
    var senderId : String?
    var receiverId : String?
    var timestamp : Int?
    
    func charPartnerId() -> String?{
        
        var partnerId : String?
        if Auth.auth().currentUser?.uid == self.senderId{
            partnerId = self.receiverId
        }else{
            partnerId = self.senderId
        }
        return partnerId
        
    }
}
