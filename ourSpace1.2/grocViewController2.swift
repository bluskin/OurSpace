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

var groceries = [Grocery]()
class grocViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var groceryTable: UITableView!
    @IBOutlet weak var newItem: UITextField!
    var ref: DatabaseReference!

    @IBAction func addItem(_ sender: AnyObject) {
        if(newItem.text! != ""){
            let groceryItem = ["item": newItem.text!
            ]
            let key = ref.child("groceries").childByAutoId().key
            ref.child("groceries").child(key).setValue(groceryItem)
            let newGrocery = Grocery(item: newItem.text!, id: key)
            groceries.append(newGrocery)
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
        
        //bckgrnd code start
        let bckgrnd = UIImageView(frame: UIScreen.main.bounds)
        bckgrnd.clipsToBounds = true
        bckgrnd.contentMode = .scaleAspectFill
        bckgrnd.image = UIImage(named: "food")
        bckgrnd.alpha = 0.1
        self.view.insertSubview(bckgrnd, at: 0)
        let blck = UIImageView(frame: UIScreen.main.bounds)
        blck.clipsToBounds = true
        blck.contentMode = .scaleAspectFill
        blck.image = UIImage(named: "blck")
        blck.alpha = 0.1
        self.view.insertSubview(blck, at: 0)
        //bckgrnd code end

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = groceries[indexPath.row].item
        cell.backgroundColor = UIColor.clear
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let deletingGrocery = groceries[indexPath.row]
            ref.child("groceries").child(deletingGrocery.id).removeValue()
            groceries.remove(at: indexPath.row)
            groceryTable.reloadData()
        }
    }
    

}
