//
//  VerifyVC.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-29.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import UIKit

class VerifyVC: UIViewController {
    
    private var user = Directory();
    private var studentID : String?
    private var studentPin: Int?
    private var studentConfirmPin: Int?
    
    
    
    @IBOutlet weak var studentIdDisplay: UITextField!


    @IBOutlet weak var studentPinDisplay: UITextField!
    
    @IBOutlet weak var studentConfirmPinDisplay: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func verifyId(_ sender: Any) {
        studentID = studentIdDisplay.text!
        
        if studentID! == "" {
            self.alertTheUser(title: "Empty ID field", message: "Plesae enter valid student ID.")
        }
        
        else{
            user.user(forID: studentID!, handler: {meta, data in
                
                if let data = data["full_name"].string{
                    print(data);
                    
                    
                }
                    
                else{
                    self.alertTheUser(title: "Student ID cannot be found", message: "Please enter valid student ID.");
                }
            })
            
        }
        
    }
    
    private func alertTheUser(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
}
