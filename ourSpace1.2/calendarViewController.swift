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
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
       cell.textLabel?.text = events[indexPath.row].name
        cell.detailTextLabel?.text = events[indexPath.row].date.description
        return cell
        
    }
    
    func setupTableView() {
        roommateCalendar.dataSource = self
        roommateCalendar.delegate = self
        roommateCalendar.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        roommateCalendar.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        roommateCalendar.reloadData()
        print("back in calendar view controller")
        print("event count is \(events.count)")
        for item in events{
            print(" Name: \(item.name)  Roommate: \(item.roommate) ")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
