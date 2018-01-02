//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jun Miao on 02/01/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [MyCategory]()
    var myCCContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

    //MARK: TableView Datasource
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "myCategoryCell", for: indexPath)
    cell.textLabel?.text = categoryArray[indexPath.row].name
    
    
    return cell
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //MARK: Data Manapulate
    
    func saveCatetory() {
        
       try! myCCContext.save()
        
        tableView.reloadData()
    }
    
    func loadCategory(with request: NSFetchRequest<MyCategory> = MyCategory.fetchRequest()) {
        do {
        categoryArray = try myCCContext.fetch(request)
        } catch {
            print("nothing at the moment")
        }
        tableView.reloadData()
        
    }
    
    //MARK: Add new Item with barButton
    

    @IBAction func catetoryBarButtonPress(_ sender: UIBarButtonItem) {
        
        var textInputFromAlert = UITextField()
        
        let alert = UIAlertController(title: "add a new item MJ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "do it now", style: .default) { (action) in
            
            let newTask = MyCategory(context: self.myCCContext)
            
            newTask.name = textInputFromAlert.text!
  
            
            self.categoryArray.append(newTask)
            
            self.saveCatetory()
            
            
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
            myDestinationVC.selectedCategoy = categoryArray[indexPath.row]
        }
        
    
        
    }
    
    
    
    
    
    
    
    
}
