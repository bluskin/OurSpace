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
            if let choresDict = snapshot.value as? [String: AnyObject]{
                chores = []
                for (id, test) in choresDict{
                    print(test)
                    let name = test["name"]!!
                    let description = test["description"]!!
                    let frequency = test["frequency"]!!
                    let turn = test["turn"]!!
                    let interval = test["startDate"]!!
                    let date = Date(timeIntervalSince1970: interval as! TimeInterval)
                    let newChore = chore(name: name as! String, description: description as! String, frequency: frequency as! String, whoTurn: turn as! String, startDate: date, ID: id)
                    chores.append(newChore)
                }
            }
            completion(true)
        })
        
    }
    func retrieveGroceries(completion: @escaping (Bool) -> ()){
        ref.child("groceries").observeSingleEvent(of: .value, with: {(snapshot) in
            if let groceriesDict = snapshot.value as? [String: AnyObject]{
                groceries = []
                for (id, test) in groceriesDict{
                    let item = test["item"]!!
                    let newGrocery = Grocery(item: item as! String, id: id)
                    groceries.append(newGrocery)
                }
            }
            completion(true)
        })
        
    }
    override func viewDidLoad() {
        retrieveChores{ success in
            if success{
                self.retrieveGroceries{ success in
                    if success{
                        super.viewDidLoad()
                        allRoomates.initialize(allRoomMate: users)
                    }
                }
            }
        
        // Do any additional setup after loading the view, typically from a nib.
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

