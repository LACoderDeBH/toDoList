//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Susana Benavidez on 5/14/18.
//  Copyright © 2018 Stanford University Clayman Institute. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDos : [ToDoCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
                getToDos()
    }
    
    //get to dos drom coredata
    func getToDos() {
        //get context
        if let context = (UIApplication.shared.delegate as?
            AppDelegate)?.persistentContainer.viewContext {
            
            //fetch:pulling information out. fetch all todo objects out of core data and
            //return them as an array of todoCoreData objects
            if let coreDataToDos = try? context.fetch(ToDoCoreData.fetchRequest()) as? [ToDoCoreData] {
                //unwrap ToDoCoreData optional array:
                if let theToDos = coreDataToDos {
                    toDos = theToDos
                    //update array means need to update table view
                    tableView.reloadData()
                }
            }
            
        }
    }
    
    
    func createToDos() -> [ToDo] {
        let eggs = ToDo()
        eggs.name = "Buy Eggs"
        eggs.important = true
        
        let dog = ToDo()
        dog.name = "Walk the dog"
        
        let cheese = ToDo()
        cheese.name = "Eat cheese"
        
        return [eggs, dog, cheese]
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let toDo = toDos[indexPath.row]
        
        if let name = toDo.name {
            if toDo.important {
                cell.textLabel?.text = "❗️" + name
            } else {
                cell.textLabel?.text = toDo.name
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        if let addVC = segue.destination as? AddViewController {
            //self refers to current class. passing a reference to current view controller over to addVC.previousVC
            addVC.previousVC = self
        }
        
        //if the segue is to teh complete page..
        if let completeVC = segue.destination as? CompleteViewController {
            
            //if toDo being sent via the sender is a ToDo object, then run code
            if let toDo = sender as? ToDoCoreData {
                completeVC.selectedToDo = toDo
                //previous VC will allow us to reference the main screen with todo items
                completeVC.previousVC = self
            }
        }
    }
}
