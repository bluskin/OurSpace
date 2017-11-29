//
//  ChoresViewController.swift
//  ourSpace1.2
//
//  Created by Claire Komyati on 11/13/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
var chores = [chore]()

class ChoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
   // let defaults:UserDefaults = UserDefaults.standard

    
    @IBOutlet weak var choreTable: UITableView!
    
    var ref: DatabaseReference!
    
    func setupTableView() {
        choreTable.dataSource = self
        choreTable.delegate = self
        choreTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return chores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = chores[indexPath.row].name
        cell.detailTextLabel?.text = chores[indexPath.row].whoTurn
        return cell
        
    }

    
    
    @IBAction func backButton(_ sender: UIButton) {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "Chores2HomeSegue", sender: self)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        choreTable.reloadData()
    }
    
    func updated_data(notification:Notification) -> Void{
        choreTable.reloadData()
        // update data here
    }
    override func viewDidLoad() {
        setupTableView()
        choreTable.reloadData()
        ref = Database.database().reference()

        print(chores.count)
        for item in chores{
            print(" Chore name: \(item.name).  Responsible: \(item.whoTurn)")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            chores.remove(at: indexPath.row)
            choreTable.reloadData()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

