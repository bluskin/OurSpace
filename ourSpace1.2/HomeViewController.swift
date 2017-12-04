//
//  HomeViewController.swift
//  ourSpace1.2
//
//  Created by Claire Komyati on 11/13/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit
import UserNotifications

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
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // clearing all existing notifications for a user
                
                for (id, test) in choresDict{
                    print(test)
                    let name = test["name"]!!
                    let description = test["description"]!!
                    let frequency = test["frequency"]!!
                    let turn = test["turn"]!!
                    let interval = test["startDate"]!!
                    let date = Date(timeIntervalSince1970: interval as! TimeInterval)
                    let newChore = chore(name: name as! String, description: description as! String, frequency: frequency as! String, whoTurn: turn as! String, startDate: date, ID: id)
                    
                    if (newChore.whoTurn == currentUser){
                        
                        let difference = -(newChore.startDate.timeIntervalSinceNow)
                        
                  
                        
                        
                        let content = UNMutableNotificationContent()
                        content.title = newChore.whoTurn + " has to " + newChore.name
                        content.body = newChore.description
                        content.subtitle = "Please complete your chore!"
                        content.badge = 1
                        
                        var time = 5
                        if (newChore.frequency == "daily"){
                            //time = Int(86400.0 - difference)
                            time = Int(30.0 - difference)
                            print ("CHORE CHANGED")
                            print (difference)
                            print (time)
                        }
                        if (newChore.frequency == "weekly"){
                            time = Int(604800.0 - difference)
                        }
                        if (newChore.frequency == "bi-weekly"){
                            time  = Int(302400.0 - difference)
                            
                        }
                        if (newChore.frequency == "monthly"){
                            time = Int(2419200.0 - difference)
                            
                        }
                        if (time > 0){
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
                        let request = UNNotificationRequest(identifier: "any", content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        }
                        
                    }


                    
                    
                    
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
    
    func retrieveCalendar(completion: @escaping (Bool) -> ()){
        ref.child("calendar").observeSingleEvent(of: .value, with: {(snapshot) in
            if let calendarDict = snapshot.value as? [String: AnyObject]{
                events = []
                for (id, test) in calendarDict{
                    let name = test["name"]!!
                    let weekDay = test["weekDay"]
                    let weekNum = test["weekNum"]
                    let interval = test["date"]
                    let roommate = test["roommate"]
                    let duration = test["duration"]
                    let date = Date(timeIntervalSince1970: interval as! TimeInterval)
                    let newEvent = calEvent(name: name as! String, weekDay: weekDay as! String, weakNum: weekNum as! Int, duration: duration as! Int, date: date, roommate: roommate as! String, id: id)
                    events.append(newEvent)
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
                        self.retrieveCalendar{ success in
                            if success{
                                super.viewDidLoad()
                                allRoomates.initialize(allRoomMate: users)
                            }
                        }
                    }
                }
            }
        
        // Do any additional setup after loading the view, typically from a nib.
        }
        //bckgrnd code start
        let bckgrnd = UIImageView(frame: UIScreen.main.bounds)
        bckgrnd.clipsToBounds = true
        bckgrnd.contentMode = .scaleAspectFill
        bckgrnd.image = UIImage(named: "washu-1")
        bckgrnd.alpha = 0.2
        self.view.insertSubview(bckgrnd, at: 0)
        let blck = UIImageView(frame: UIScreen.main.bounds)
        blck.clipsToBounds = true
        blck.contentMode = .scaleAspectFill
        blck.image = UIImage(named: "blck")
        blck.alpha = 0.9
        self.view.insertSubview(blck, at: 0)
        //bckgrnd code end
    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

