//
//  HomeViewController.swift
//  ourSpace1.2
//
//  Created by Claire Komyati on 11/13/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit

    var allRoomates = roommateWheel()
   // initialize(allRoomMate: ["Claire", "Nathan" , "David", "Ben"])


class HomeViewController: UIViewController {
    
    let list = LinkedList<String>()

    
    
    
    
    @IBAction func groceryViewButton(_ sender: UIButton) {
        print ("grocery button pressed!!")
       // self.performSegue(withIdentifier: "GroceryViewSegue", sender: self)
    }
    
    @IBAction func choresViewButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ChoresSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allRoomates.initialize(allRoomMate: ["Claire", "Nathan" , "David", "Ben"])

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

