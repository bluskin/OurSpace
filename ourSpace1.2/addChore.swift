//
//  addChore.swift
//  ourSpace1.2
//
//  Created by Nathan Gartlan on 11/25/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import Foundation
import UIKit

import Firebase
import FirebaseDatabase
import UserNotifications

class addChore: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var frequency: UITextField!
    
    @IBOutlet weak var whoChore: UITextField!
    
    @IBOutlet weak var describe: UITextField!
    @IBOutlet weak var roomieDrop: UIPickerView!
    var ref: DatabaseReference!

    
    @IBAction func addChore(_ sender: AnyObject) {
        

        var nextChore = chore(name:name.text!, description:describe.text!, frequency:frequency.text!, whoTurn:whoChore.text!, startDate: Date(), ID: "")
        
        let interval =  nextChore.startDate.timeIntervalSince1970
    generateNotification()
        
        if(name.text! != "" || frequency.text! != "" || whoChore.text! != "" || describe.text! != ""){
            let chore = [ "name": nextChore.name,
                    "description": nextChore.description,
                    "frequency": nextChore.frequency,
                    "turn": nextChore.whoTurn,
                    "startDate": interval
            ] as [String : Any]
            let key = ref.child("chores").childByAutoId().key
            nextChore.ID = key
            ref.child("chores").child(key).setValue(chore)
            chores.append(nextChore)
        }
        
        
    }

 
    var list = [" "]
    
    let freqOptions = [" ","daily","weekly", "bi-weekly","monthly"]
    
    
    
    
    func generateNotification(){
        let content = UNMutableNotificationContent()
        content.title = whoChore.text! + " has to " + name.text!
        content.body = describe.text!
        content.subtitle = "do it!"
        content.badge = 1
        
        var time = 5
        if (frequency.text! == "daily"){
            //time = 86400
            time = 5
            print ("HERE1")
        }
        if (frequency.text! == "weekly"){
            time = 604800
            print("HERE2")
        }
        if (frequency.text! == "bi-weekly"){
            time  = 302400
            print ("HERE3)")
        }
        if (frequency.text! == "monthly"){
            time = 2419200
            print ("HERE4")
        }
        
  
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        let request = UNNotificationRequest(identifier: "any", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print ("helllllo")
    }

    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 1)
        {
            return list.count;
        }
        else
        {
            return freqOptions.count;
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
         self.view.endEditing(true)
        if(component == 1){
            return list[row]
        }else{
            return freqOptions[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(component == 1){
            whoChore.text = list[row]
        }else{
            frequency.text = freqOptions[row]
        }
        
        roomieDrop.isHidden = true
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        if (textField == self.whoChore){
            roomieDrop.isHidden = false
        }else if (textField == self.frequency){
            roomieDrop.isHidden = false
        }
    }
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        for item in allRoomates.roomArray{
            list.append(item)
        }
    
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
