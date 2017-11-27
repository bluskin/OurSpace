//
//  addChore.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/25/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import Foundation
import UIKit

class addChore: UIViewController {
    
    
   
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var frequency: UITextField!
    
    @IBOutlet weak var whoChore: UITextField!
    
    @IBOutlet weak var describe: UITextField!

    @IBAction func addChore(_ sender: AnyObject) {
        
        let nextChore = chore(name:name.text!, description:describe.text!, frequency:frequency.text!, whoTurn:whoChore.text!)
        
        chores.append(nextChore)
       // UserDefaults.standard().setObject
  
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
