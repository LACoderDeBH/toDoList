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
        let toDo = ToDo()
        
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
            
        }
    }
    
}
