//
//  AddViewController.swift
//  ToDoList
//
//  Created by Susana Benavidez on 5/14/18.
//  Copyright © 2018 Stanford University Clayman Institute. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    //reference to previous viewcontroller
    var previousVC = ToDoTableViewController()
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var importantSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //make new ToDo item
    @IBAction func addTapped(_ sender: Any) {
     /*   let toDo = ToDo()
        
        //check if text field is not empty to proceed
        if let titleText = titleTextField.text {
            toDo.name = titleText
            toDo.important = importantSwitch.isOn
            
            //toDos is the array of todo's and add new toDo
            previousVC.toDos.append(toDo)
            //refresh table view to update items added
            previousVC.tableView.reloadData()
            
            //move back a view controller (pooping) after you add a todo item
            navigationController?.popViewController(animated: true)
            
        }*/
        
        //1. Lines 47-48: Get context from AppDelegate. context is a managed object context
        //which is a bridge to core data so both can talk
        if let context = (UIApplication.shared.delegate as?
            AppDelegate)?.persistentContainer.viewContext {
            
            //2. create toDoCoreData object
            let toDo = ToDoCoreData(entity: ToDoCoreData.entity(), insertInto: context)
            
            //3. set toDo's name and whether it was important
            if let titleText = titleTextField.text {
                toDo.name = titleText
                toDo.important = importantSwitch.isOn
            }
            //4. save the context on coredata
            try? context.save()
            
            //5. Pop view controller because we want to move back to prev view (popping)
            //after you add a todo item
            navigationController?.popViewController(animated: true)
        }
        
    }
    
}
