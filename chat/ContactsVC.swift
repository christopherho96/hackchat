//
//  ContactsVC.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-26.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(_ sender: Any) {
        dismiss(animated:true, completion:nil);
    }
} //class
