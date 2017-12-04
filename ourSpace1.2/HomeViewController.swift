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
    func retrieveChores(completion: @escaping (Bool) -> ()){
        ref.child("chores").observeSingleEvent(of: .value, with: {(snapshot) in
            let choresDict = snapshot.value as! [String: AnyObject]
            for (id, test) in choresDict{
                print(test)
                let name = test["name"]!!
                let description = test["description"]!!
                let frequency = test["frequency"]!!
                let turn = test["turn"]!!
                let newChore = chore(name: name as! String, description: description as! String, frequency: frequency as! Int, whoTurn: turn as! String, ID: id)
                chores.append(newChore)
            }
            completion(true)
        })
        
    }
    override func viewDidLoad() {
        retrieveChores{ success in
            if success{
                super.viewDidLoad()
                allRoomates.initialize(allRoomMate: users)
            }
        
        // Do any additional setup after loading the view, typically from a nib.
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

