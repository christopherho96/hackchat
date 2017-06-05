//
//  VerifyVC.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-29.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import UIKit

class VerifyVC: UIViewController {
    
    private var studentID : String?
    private var studentPin: Int?
    private var studentConfirmPin: Int?
    private var studentName: String?
    private var studentEmail: String?
    
    
    
    @IBOutlet weak var studentIdDisplay: UITextField!

    @IBOutlet weak var pinDescription: UILabel!
    
    @IBOutlet weak var pinTextField: UITextField!
    
    @IBOutlet weak var pinVerifyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinDescription.isHidden = true
        pinTextField.isHidden = true
        pinVerifyButton.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func verifyId(_ sender: Any) {
        
        if studentIdDisplay.text == "" {
            self.alertTheUser(title: "Empty ID field", message: "Plesae enter valid student ID.")
        }
        
        else{
            studentID = studentIdDisplay.text!
            WatSwift.Directory.user(forID: studentID!, handler: {response in
                
                let data: JSON = response.data
                if self.studentID! ==  data["user_id"].string{
                    
                    self.studentEmail = data["email_addresses"][0].string
                    self.studentName = data["full_name"].string
                    //print(self.studentEmail!)
                    //print(self.studentName!)
                    
                    self.alertTheUser(title: "Student ID Confirmed", message: "A 6-digit pin has been sent to your student email.");
                    
                    self.pinDescription.isHidden = false
                    self.pinTextField.isHidden = false
                    self.pinVerifyButton.isHidden = false
                    
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
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
