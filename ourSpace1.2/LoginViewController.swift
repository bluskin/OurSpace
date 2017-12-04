//
//  LoginViewController.swift
//  ourSpace1.2
//
//  Created by labuser on 11/19/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
var currentUser:String = ""
var ref: DatabaseReference!

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
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
    
    @IBAction func editingPassword(_ sender: Any) {
        if passwordField.text == "Password"{
            passwordField.text = "";
        }
        passwordField.isSecureTextEntry = true;
    }
    
    @IBAction func passwordEnded(_ sender: Any) {
        if passwordField.text == ""{
            passwordField.text = "Password";
            passwordField.isSecureTextEntry = false;
        }
    }
    
    @IBAction func login(_ sender: Any) {
        if let email = emailField.text{
            if let password = passwordField.text{
                Auth.auth().signIn(withEmail: email, password: password){(user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                       // self.showMessagePrompt(error.localizedDescription)
                        return
                    }
                    else{
                        print("users")
                        self.retrieveUsers{ success in
                            if success{
                                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                let secondView = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController")
                                self.present(secondView, animated: true, completion: nil)

                            }
                            else{
                                print("failed")
                            }
                        }
                    }
                }
            }
        }
    }
    func retrieveUsers(completion: @escaping (Bool) -> ()){
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").observeSingleEvent(of: .value, with: {(snapshot) in
            let usersDict = snapshot.value as! [String: AnyObject]
            for (id, test) in usersDict{
                let name = test["name"]
                users.append(name!! as! String)
                if(id == userID!){
                    currentUser = name!! as! String
                }
            }
            completion(true)
        })

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
