//
//  addCalendarItem.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/25/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class addCalendarItem: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectedWeekDay = 0
    
    var newDate: Date? = nil
    
    @IBOutlet weak var dateField: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var dHours: UITextField!
    @IBOutlet weak var dMinutes: UITextField!
    
    @IBAction func cancelItem(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var weekDay: UITextField!
    
    @IBOutlet weak var weekDayPicker: UIPickerView!
    
    @IBAction func addItem(_ sender: AnyObject) {
        if(newDate != nil){
            var nextEvent = calEvent(name: eventName.text!, weekDay: weekDay.text!, weakNum: selectedWeekDay, duration: (Int(dHours.text!)!*60 + Int(dMinutes.text!)!) , date: newDate!, roommate: currentUser, id: "")
            let key = ref.child("calendar").childByAutoId().key
            nextEvent.id = key
            let interval = nextEvent.date.timeIntervalSince1970
            let event = [
                "name": nextEvent.name,
                "weekDay": nextEvent.weekDay,
                "weekNum": nextEvent.weakNum,
                "date": interval,
                "roommate": currentUser,
                "duration": nextEvent.duration
            ] as [String : Any]
            events.append(nextEvent)
            ref.child("calendar").child(key).setValue(event)
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
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        
        
        dateField.text = dateFormatter.string(from: datePicker.date)
        newDate = datePicker.date
        self.view.endEditing(true)
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return 24
        }else if(component == 1){
            return 60
        }else{
        return weekdays.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        self.view.endEditing(true)
        if(component == 0){
            return "\(row)"
        }else if(component == 1){
            return "\(row)"
        }else{
            return weekdays[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
     
        if(component == 0){
            dHours.text = "\(row)"
        }else if(component == 1){
            dMinutes.text = "\(row)"
        }else{
            weekDay.text = weekdays[row]
            selectedWeekDay = row
        }
        weekDayPicker.isHidden = true
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        if(textField == self.weekDay){
            weekDayPicker.isHidden = false
        }
        if(textField == self.dHours){
            weekDayPicker.isHidden = false
        }
        if(textField == self.dMinutes){
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
