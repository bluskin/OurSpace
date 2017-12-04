//
//  grocViewController2.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/26/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

var groceries = [String]()
class grocViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var groceryTable: UITableView!
    @IBOutlet weak var newItem: UITextField!
    var ref: DatabaseReference!

    @IBAction func addItem(_ sender: AnyObject) {
        if(newItem.text! != ""){
            groceries.append(newItem.text!)
            let userID = Auth.auth().currentUser?.uid
            let groceryItem = ["host": userID,
                               "item": newItem.text!
            ]
            self.ref.child("groceries").childByAutoId().setValue(groceryItem)
            groceryTable.reloadData()
            newItem.text = ""
        }
    }
    
    func setupTableView() {
        groceryTable.dataSource = self
        groceryTable.delegate = self
        groceryTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        ref = Database.database().reference()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = groceries[indexPath.row]
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            groceries.remove(at: indexPath.row)
            groceryTable.reloadData()
        }
    }
    

}
