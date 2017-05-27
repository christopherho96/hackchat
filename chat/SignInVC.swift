//
//  SignInVC.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-26.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import UIKit
import Firebase

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
        if emailTextField.text! != "" && passwordTextField.text != ""{
         
            AuthProvider.Instance.login(withEmail: emailTextField.text!, password: passwordTextField.text! , loginHandler: {
                (message) in
                
                if message != nil{
                    self.alertTheUser(title: "Problem with authentication", message: message!);
                }else{
                    print("login completed");
                }
            });
            
        }
    }




    @IBAction func signUp(_ sender: Any) {
        
    }

    private func alertTheUser(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
} // class


