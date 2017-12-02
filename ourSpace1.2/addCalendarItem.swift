//
//  addCalendarItem.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/25/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import Foundation
import UIKit

class addCalendarItem: UIViewController {
    
    var newDate: Date? = nil
    
    @IBOutlet weak var dateField: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var roommateName: UITextField!
    @IBAction func cancelItem(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addItem(_ sender: AnyObject) {
        if(newDate != nil){
        let nextEvent = calEvent(name: eventName.text!, date: newDate!, roommate: roommateName.text!)
        events.append(nextEvent)
        print("Event title \(nextEvent.name) Event date \(nextEvent.date.description) ")
        
        print("hello world")
    
        
        dismiss(animated: true, completion: nil)
        }
        
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateField.inputAccessoryView = toolbar
        
        //date picker and text field
        dateField.inputView = datePicker
    }
    
    func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        dateField.text = dateFormatter.string(from: datePicker.date)
        //dismiss datePicker
        newDate = datePicker.date
        self.view.endEditing(true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        print(events.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
