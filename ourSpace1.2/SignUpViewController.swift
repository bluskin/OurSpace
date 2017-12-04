//
//  SignUpViewController.swift
//  ourSpace1.2
//
//  Created by labuser on 11/19/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
var users = [String]()

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var equalLabel: UILabel!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var secondPassword: UITextField!
    var ref: DatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
        equalLabel.text = ""
        firstName.text = "First Name"
        lastName.text = "Last Name"
    }
    
    @IBAction func editingEmail(_ sender: Any) {
        if emailField.text == "Email"{
            emailField.text = "";
        }
    }
    
    @IBAction func emailEntered(_ sender: Any) {
        if emailField.text == ""{
            emailField.text = "Email";
        }
    }
    @IBAction func changedFirstName(_ sender: Any) {
        print(firstName.text!)
        if firstName.text == "First Name"{
            firstName.text = ""
        }
    }
    @IBAction func firstNameEntered(_ sender: Any) {
        if firstName.text == ""{
            firstName.text = "First Name"
        }
    }
    @IBAction func changedLastName(_ sender: Any) {
        if lastName.text == "Last Name"{
            lastName.text = ""
        }
    }
    
    @IBAction func lastNameEntered(_ sender: Any) {
        if lastName.text == ""{
            lastName.text = "Last Name"
        }
    }
    @IBAction func editingPassword(_ sender: Any) {
        if passwordField.text == "Password"{
            passwordField.text = "";
        }
        passwordField.isSecureTextEntry = true;
        equalLabel.text = ""
    }
    
    @IBAction func passwordEnded(_ sender: Any) {
        if secondPassword.text == ""{
            secondPassword.text = "Password";
            secondPassword.isSecureTextEntry = false;
        }
    }
    
    @IBAction func editingSecondPassword(_ sender: Any) {
        if secondPassword.text == "Re-enter Password"{
            secondPassword.text = "";
        }
        secondPassword.isSecureTextEntry = true;
        equalLabel.text = ""
    }
    @IBAction func secondPasswordEntered(_ sender: Any) {
        if secondPassword.text == ""{
            secondPassword.text = "Re-enter Password";
            secondPassword.isSecureTextEntry = false;
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        if secondPassword.text != passwordField.text{
            equalLabel.text = "Passwords do not match";
        }
        if let email = emailField.text{
            if let password = passwordField.text{
                Auth.auth().createUser(withEmail: email, password: password){ ( user, error) in
                    if let error = error {
                        self.equalLabel.text = error.localizedDescription
                        //self.showMessagePrompt(error.localizedDescription)
                        return
                    }
                    else{
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let secondView = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
                        let userID = Auth.auth().currentUser?.uid
                        let name = self.firstName.text!
                        let user = ["name": name
                        ]
                        self.ref.child("users").child(userID!).setValue(user)
                        self.present(secondView, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
