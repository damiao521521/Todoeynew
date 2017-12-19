//
//  ViewController.swift
//  Todoey
//
//  Created by Jun Miao on 18/12/2017.
//  Copyright © 2017 Jun Miao. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    //MARK: - tableView Method - DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //MARK: - tableView Method - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
      tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        print(itemArray[indexPath.row])
    }
    
    //MARK: - Add Bar Button to 

    @IBAction func addNewlist(_ sender: UIBarButtonItem) {
        
        var textInputFromAlert : String = ""
        
        let alert = UIAlertController(title: "add a new item MJ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "do it now", style: .default) { (action) in
            print(textInputFromAlert)
        }
        alert.addTextField { (textYouInput) in
            textYouInput.placeholder = "say come on come on"
           textInputFromAlert = textYouInput.text!
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

