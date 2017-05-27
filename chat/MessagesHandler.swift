//
//  MessagesHandler.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-27.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class MessagesHandler{
    private static let _instance = MessagesHandler();
    private init() {}
    
    static var Instance : MessagesHandler {
        return _instance;
    }
    
    func sendMessage(senderID : String, senderName: String, text: String){
        
        let data: Dictionary<String,Any> = [Constants.SENDER_ID: senderID, Constants.SENDER_NAME: senderName, Constants.TEXT: text];
        
        DBProvider.Instance.messagesRef.childByAutoId().setValue(data);
        
    }
    
    func observeMessages(){
        DBProvider.Instance.messagesRef.observe(FirDataEventType.childAdded, with: (FirsDataSnapshot)-> Void);
    }
    
}//class
