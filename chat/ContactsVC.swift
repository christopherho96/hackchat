//
//  ContactsVC.swift
//  chat
//
//  Created by Christopher Ho on 2017-05-26.
//  Copyright © 2017 Christopher Ho. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, FetchData {

    @IBOutlet weak var myTable: UITableView!
    
    private let CELL_ID = "Cell";
    
    private var contacts = [Contact]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DBProvider.Instance.delegate = self;
        
        DBProvider.Instance.getContacts();
    }
    
    func dataReceived(contacts: [Contact]) {
        self.contacts = contacts;
        
        //get the name of current user
        
        myTable.reloadData();
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return contacts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        
        cell.textLabel?.text = contacts[indexPath.row].name;
        
        return cell;
    }
    
    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logOut(){
            dismiss(animated: true, completion: nil);
        }
    }
} //class
