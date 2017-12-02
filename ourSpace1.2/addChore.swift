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

class addChore: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var frequency: UITextField!
    
    @IBOutlet weak var whoChore: UITextField!
    
    @IBOutlet weak var describe: UITextField!
    @IBOutlet weak var roomieDrop: UIPickerView!
    var ref: DatabaseReference!

    
    @IBAction func addChore(_ sender: AnyObject) {
        
        let nextChore = chore(name:name.text!, description:describe.text!, frequency:frequency.text!, whoTurn:whoChore.text!)
        
        if(name.text! != "" || frequency.text! != "" || whoChore.text! != "" || describe.text! != ""){
            chores.append(nextChore)
            let chore = [ "name": nextChore.name,
                          "description": nextChore.description,
                          "frequency": nextChore.frequency,
                          "turn": nextChore.whoTurn
            ]
            ref.child("chores").childByAutoId().setValue(chore)
        }
    }

 
    var list = [" "]
    
    let freqOptions = [" ","daily","weekly", "bi-weekly","monthly"]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0)
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
        if(component == 0){
            return list[row]
        }else{
            return freqOptions[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if(component == 0){
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
