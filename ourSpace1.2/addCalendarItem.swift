//
//  addCalendarItem.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/25/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import Foundation
import UIKit

class addCalendarItem: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectedWeekDay = 0
    
    var newDate: Date? = nil
    
    @IBOutlet weak var dateField: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var roommateName: UITextField!
    @IBAction func cancelItem(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var weekDay: UITextField!
    
    @IBOutlet weak var weekDayPicker: UIPickerView!
    
    @IBAction func addItem(_ sender: AnyObject) {
        if(newDate != nil){
        let nextEvent = calEvent(name: eventName.text!, weekDay: weekDay.text!, weakNum: selectedWeekDay, date: newDate!, roommate: roommateName.text!)
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
        datePicker.datePickerMode = .time
        //date picker and text field
        dateField.inputView = datePicker
    }
    
    func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        
        
        dateField.text = dateFormatter.string(from: datePicker.date)
        newDate = datePicker.date
        self.view.endEditing(true)
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weekdays.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        self.view.endEditing(true)
        
        return weekdays[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
       
        weekDay.text = weekdays[row]
        selectedWeekDay = row
        weekDayPicker.isHidden = true
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        if(textField == self.weekDay){
            weekDayPicker.isHidden = false
        }
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
