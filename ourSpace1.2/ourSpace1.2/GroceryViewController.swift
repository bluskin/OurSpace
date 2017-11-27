//
//  GroceryViewController.swift
//  ourSpace1.2
//
//  Created by Claire Komyati on 11/13/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit

class GroceryViewController: UIViewController {
    
    
    @IBAction func backButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
        
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

