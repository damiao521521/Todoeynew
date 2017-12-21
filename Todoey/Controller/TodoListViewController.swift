//
//  ViewController.swift
//  Todoey
//
//  Created by Jun Miao on 18/12/2017.
//  Copyright © 2017 Jun Miao. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")

    
    var itemArray = [myDataModel]()
   // var checkedArray : [String] = []
  //  let myDefaults = UserDefaults.standard
    let myListName = "defaultDatabase"

    override func viewDidLoad() {
        super.viewDidLoad()
        
print(dataFilePath)
        
        // Do any additional setup after loading the view, typically from a nib.
//        if let tempArray = myDefaults.array(forKey: myListName) as? [myDataModel] {
//            itemArray = tempArray
//        }
        
//        let newItem = myDataModel()
//        newItem.myTask = "Find Mike"
//        newItem.myDone = true
//        itemArray.append(newItem)
//
//        let newItem2 = myDataModel()
//        newItem2.myTask = "Find Jack"
//        itemArray.append(newItem2)
//
//        let newItem3 = myDataModel()
//        newItem3.myTask = "Find Rose"
//        itemArray.append(newItem3)
        
        loadData()
        
    }


    //MARK: - tableView Method - DataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //   let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.myTask
        //      print(indexPath.row)
        
        // below is the famous ternary operator !!!
        cell.accessoryType = itemArray[indexPath.row].myDone == true ? .checkmark : .none
        
//        if itemArray[indexPath.row].myDone == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//
//        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    //MARK: - tableView Method - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
       itemArray[indexPath.row].myDone = !itemArray[indexPath.row].myDone
        saveData()
     
        
//        if itemArray[indexPath.row].myDone == true {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//          //  checkedArray.remove(at: indexPath.row)
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//          //  checkedArray.append(itemArray[indexPath.row])
//        }
        
        print("now the indexPath is : \(indexPath.row) ")
        

        
    }
    
    //MARK: - Add Bar Button to 

    @IBAction func addNewlist(_ sender: UIBarButtonItem) {
        
        var textInputFromAlert = UITextField()
        
        let alert = UIAlertController(title: "add a new item MJ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "do it now", style: .default) { (action) in
            
            let newTask = myDataModel()
            
            newTask.myTask = textInputFromAlert.text!
            
            self.itemArray.append(newTask)
            
            print("now the cell number is \(self.itemArray.count)")
            
            self.saveData()
            
            // self.myDefaults.set(self.itemArray, forKey: self.myListName)
            
        }
        alert.addTextField { (textYouInput) in
            textYouInput.placeholder = "say come on come on"
            
            textInputFromAlert = textYouInput
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveData () {

        let encoder = PropertyListEncoder() // instance the encoder , you take this is the formatter , once you have the formatter ,format your data first;format your data to encodable.
        
        do {
            let myData = try encoder.encode(itemArray)  //format your data to encodable, and put in the buffer
            try myData.write(to: dataFilePath!)  //once when your data is converted to encodable, it can be "write" into the file system
        }
        catch {
            print(error)
        }
                tableView.reloadData()
    }
    
    func loadData() {
        
        
        if let myData = try? Data(contentsOf: dataFilePath!) {
            let myDecoder = PropertyListDecoder()
            do {
                itemArray = try myDecoder.decode([myDataModel].self, from: myData)
            }
            catch {
                print(error)
            }
        }
        
    
    }
    
}

