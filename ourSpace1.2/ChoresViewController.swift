//
//  ChoresViewController.swift
//  ourSpace1.2
//
//  Created by Claire Komyati on 11/13/17.
//  Copyright © 2017 Claire Komyati. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var chores = [chore]()

class ChoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningText: UITextView!
    

    @IBAction func yesButton(_ sender: AnyObject) {
        //itemDeleted = true
        if(taskIdentifer == "delete"){
        chores.remove(at: deleteIndex)
        }
        else{
            let currentPerson = chores[completeIndex].whoTurn
            let nextPerson = allRoomates.nextRoomMate(a: currentPerson )
            chores[completeIndex].whoTurn = nextPerson
            chores[completeIndex].startDate = Date()
            choreTable.reloadData()
            
        }
        choreTable.reloadData()
        warningView.isHidden = true
    }
    @IBAction func noButton(_ sender: AnyObject) {
        warningView.isHidden = true
    }
    var itemDeleted = false
    var choreCompleted = false
    var deleteIndex = 0
    var completeIndex = 0
    var taskIdentifer = "delete"


    
    @IBOutlet weak var choreTable: UITableView!
    
    var ref: DatabaseReference!
    
    //initialize the tableview
    func setupTableView() {
        choreTable.dataSource = self
        choreTable.delegate = self
        choreTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return chores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = chores[indexPath.row].name
        cell.detailTextLabel?.text = chores[indexPath.row].whoTurn
        return cell
        
    }

    
    
    @IBAction func backButton(_ sender: UIButton) {
        super.viewDidLoad()
        self.performSegue(withIdentifier: "Chores2HomeSegue", sender: self)
        
        //view.addSubview(setUpDeleteWarning())
    }

    
    override func viewDidAppear(_ animated: Bool) {
        choreTable.reloadData()
    }
    
    func updated_data(notification:Notification) -> Void{
        choreTable.reloadData()
        // update data here
    }
    override func viewDidLoad() {
        setupTableView()
        warningText.backgroundColor = UIColor.clear
        choreTable.reloadData()
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let complete = UITableViewRowAction(style: .normal, title: "Complete", handler: {ACTION, indexPath in self.completedFunctionality(path: indexPath)
        })
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete", handler: {ACTION, indexPath in print("deleted task")
        self.deleteFunctionality(path: indexPath)})
        delete.backgroundColor = UIColor.red
        return [delete,complete]
    }
    
    //set the delete index, delete done in the "yes" button
    func deleteFunctionality(path: IndexPath){
                taskIdentifer = "delete"
                warningView.isHidden = false;
                warningText.text = "Are you sure you want to delete this item?"
        
                deleteIndex = path.row
                if(itemDeleted){
                        chores.remove(at: path.row)
                        choreTable.reloadData()
                    }
            print( "was item delected? \(itemDeleted)")
                    itemDeleted = false
                
    }
    //set the complete index, complete function done in the "yes" button
    func completedFunctionality(path: IndexPath){
        taskIdentifer = "complete"
        warningView.isHidden = false;
        warningText.text = "Are you sure you completed this chore?"
        completeIndex = path.row

        print("complete index is \(completeIndex)")
        choreCompleted = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

