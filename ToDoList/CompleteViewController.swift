//
//  CompleteViewController.swift
//  ToDoList
//
//  Created by Susana Benavidez on 5/15/18.
//  Copyright © 2018 Stanford University Clayman Institute. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {

    //reference to previous viewcontroller
    var previousVC = ToDoTableViewController()
    var selectedToDo = ToDo() //generic ToDo object
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //what to display for this view: item about to me marked complete
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = selectedToDo.name
    }

    @IBAction func completeTapped(_ sender: Any) {
        var index = 0
        for toDo in previousVC.toDos {
            if toDo.name == selectedToDo.name {
                print("we found it \(toDo.name)")
                previousVC.toDos.remove(at: index)
                previousVC.tableView.reloadData()
                navigationController?.popViewController(animated: true)
                break
            }
            index += 1
        }
    }
}
