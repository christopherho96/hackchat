//
//  Contact.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-27.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import Foundation

class Contact{
    
    private var _name = "";
    private var _id = "";
    
    init(id:String, name: String){
        _id = id;
        _name = name;
        
    }
    
    var name: String {
        get{
            return _name;
        }
    }
    
    var id: String{
        return _id;
    }
}
