//
//  ViewController.swift
//  Todoey
//
//  Created by Jun Miao on 18/12/2017.
//  Copyright © 2017 Jun Miao. All rights reserved.
//

import UIKit
import CoreData


class ToDoListViewController: UITableViewController {
    
 //   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
  
    
    var selectedCategoy : MyCategory? {
        didSet {
            
            loadData()
        }
    }
    
    
    var itemArray = [MyItem]()
    

 

    override func viewDidLoad() {
        super.viewDidLoad()


        
    }


    //MARK: - tableView Method - DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //   let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
       
        // below is the famous ternary operator !!!
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    //MARK: - tableView Method - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        myContext.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        
     //  itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveData()

        
    }
    
    //MARK: - Add Bar Button to 

    @IBAction func addNewlist(_ sender: UIBarButtonItem) {
        
        var textInputFromAlert = UITextField()
        
        let alert = UIAlertController(title: "add a new item MJ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "do it now", style: .default) { (action) in
            
            let newTask = MyItem(context: self.myContext)
            
            newTask.title = textInputFromAlert.text!
            newTask.done = false
            newTask.parentMyCategory = self.selectedCategoy
            print(newTask.parentMyCategory?.name)
            
            self.itemArray.append(newTask)
            
            self.saveData()
            
            
        }
        alert.addTextField { (textYouInput) in
            textYouInput.placeholder = "say come on come on"
            
            textInputFromAlert = textYouInput
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveData () {
        
       try! myContext.save()

       tableView.reloadData()
        
    }
    
    func loadData(with myRequest : NSFetchRequest<MyItem> = MyItem.fetchRequest(), of myPredicate : NSPredicate? = nil ) {
        
        let searchPredicate1 = NSPredicate(format: "parentMyCategory.name MATCHES %@", selectedCategoy!.name!)
        
        if let tempPredicate = myPredicate {
        myRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [searchPredicate1,tempPredicate])
        } else {
            myRequest.predicate = searchPredicate1
        }
        
       itemArray =  try! myContext.fetch(myRequest)
           tableView.reloadData()
    }
    

    

}

extension ToDoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let myRequest : NSFetchRequest<MyItem> = MyItem.fetchRequest()
        
        print(searchBar.text!)
        

       let searchPredicate2 = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

        myRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
      loadData(with: myRequest, of: searchPredicate2)
        
        
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadData()
            DispatchQueue.main.async {
                
                 searchBar.resignFirstResponder()
                
            }
            
        }
        
    }
}














