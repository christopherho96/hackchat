//
//  SignInVC.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-26.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    private let CONTACTS_SEGUE = "ContactsSegue"

    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: CONTACTS_SEGUE, sender: nil);
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
    }

} // class


