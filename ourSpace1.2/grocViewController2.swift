//
//  grocViewController2.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/26/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import Foundation
import UIKit

var groceries = [String]()
class grocViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var groceryList: UITableView!
  
    @IBOutlet weak var newGroc: UITextField!
    
    @IBAction func addGroc(_ sender: AnyObject) {
        groceries.append(newGroc.text!)
        //newGroc.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

}
