//
//  ViewController.swift
//  Todoey
//
//  Created by Jun Miao on 18/12/2017.
//  Copyright © 2017 Jun Miao. All rights reserved.
//

import UIKit
import RealmSwift


class ToDoListViewController: UITableViewController {
    
 //   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    

    
    
    let myRealm = try! Realm()
  
    
    var selectedCategoy : RealmCategory? {
        didSet {
            
           loadData()
        }
    }
    
    
    var todoItems : Results<RealmItem>?
    

    

    override func viewDidLoad() {
        super.viewDidLoad()


        
    }


    //MARK: - tableView Method - DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //   let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item =  todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            // below is the famous ternary operator !!!
            
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else {
            cell.textLabel?.text = "there is no item"
        }
        
      
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }

    
    //MARK: - tableView Method - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if let tempToDo = todoItems?[indexPath.row] {
           
            do {
                try myRealm.write {
                    tempToDo.done = !tempToDo.done
                }
            }catch {
                print("somthing wrong \(error)")
            }
            
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        
        }
    
    //MARK: - Add Bar Button to 

    @IBAction func addNewlist(_ sender: UIBarButtonItem) {
        
        var textInputFromAlert = UITextField()
        
        let alert = UIAlertController(title: "add a new item MJ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "do it now", style: .default) { (action) in
            
            if let tempcategoary = self.selectedCategoy {

            
            do {
                try self.myRealm.write {
                    
                    let newTask = RealmItem()
                    newTask.title = textInputFromAlert.text!
                    tempcategoary.items.append(newTask)  //after eating , good good study
                    
                  //  self.myRealm.add(newTask)
                }
            }catch {
                print(error)
            }
            }
           
          self.tableView.reloadData()
            
 
            
            
        }
        alert.addTextField { (textYouInput) in
            textYouInput.placeholder = "say come on come on"
            
            textInputFromAlert = textYouInput
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

    
    func loadData() {
        
   todoItems = selectedCategoy?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()

    }
    

    

}

extension ToDoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()

    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.count == 0 {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
}
}













