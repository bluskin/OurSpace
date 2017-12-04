//
//  calendarViewController.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/25/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit

var events = [calEvent]()
class calendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var roommateCalendar: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return  events.count
    }
    func updated_data(notification:Notification) -> Void{
        roommateCalendar.reloadData()
        // update data here
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
       cell.textLabel?.text = "\(events[indexPath.row].roommate): \(events[indexPath.row].name)"
        
    
        let date = events[indexPath.row].date
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
    
        dateFormatter.timeStyle = .short
        
        
        
        let timeDisplay = dateFormatter.string(from: date)
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)

        let weekDay = events[indexPath.row].weekDay
         cell.detailTextLabel?.text = "\(weekDay) at \(timeDisplay)"
        return cell
        
    }
    
    func setupTableView() {
        roommateCalendar.dataSource = self
        roommateCalendar.delegate = self
        roommateCalendar.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        events.sort { (event1, event2) -> Bool in
            
            let calendar = Calendar.current
           
            let startHour1 = calendar.component(.hour, from: event1.date)
            let startHour2 = calendar.component(.hour, from: event2.date)
            let startMinute1 = calendar.component(.minute, from: event1.date)
            let startMinute2 = calendar.component(.minute, from: event2.date)
            if(event1.weakNum == event2.weakNum){
                if(startHour1 == startHour2){
                    return startMinute1 < startMinute2
                }else{
                    return startHour1 < startHour2
                }
            }else{
            
            return (event1.weakNum < event2.weakNum)
        }
        
    }
        roommateCalendar.reloadData()
    }
    
    //for deleting from favorites list
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            events.remove(at: indexPath.row)
            roommateCalendar.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        roommateCalendar.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
