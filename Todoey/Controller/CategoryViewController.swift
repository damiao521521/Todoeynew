//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jun Miao on 02/01/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryresults : Results<RealmCategory>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

    //MARK: TableView Datasource
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCategoryCell", for: indexPath)
    cell.textLabel?.text = categoryresults?[indexPath.row].name ?? "come on Sir what do you want from Nil"
    
    
    return cell
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryresults?.count  ?? 1
    }
    
    //MARK: Data Manapulate
    
    func save(object the : RealmCategory) {
        do {
           try realm.write {
            
                realm.add(the)
            
            }
        }catch {
            print(error)
        }
      
        tableView.reloadData()
    }
    
    func loadCategory() {
        
      categoryresults =  realm.objects(RealmCategory.self)
        
        tableView.reloadData()
        
    }
    
    //MARK: Add new Item with barButton
    

    @IBAction func catetoryBarButtonPress(_ sender: UIBarButtonItem) {
        
        var textInputFromAlert = UITextField()
        
        let alert = UIAlertController(title: "add a new item MJ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "do it now", style: .default) { (action) in
            
            let newTask = RealmCategory()
            
            newTask.name = textInputFromAlert.text!

            
            self.save(object: newTask)
            
            
        }
        alert.addTextField { (textYouInput) in
            textYouInput.placeholder = "say come on come on"
            textInputFromAlert = textYouInput
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }

    
    //MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    performSegue(withIdentifier: "myGoToItems", sender: self)
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myDestinationVC = segue.destination as! ToDoListViewController
    
        if let indexPath = tableView.indexPathForSelectedRow {
            myDestinationVC.selectedCategoy = categoryresults?[indexPath.row]
        }
        
    
        
    }
    
    
    
    
    
    
    
    
}
