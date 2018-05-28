//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Tee Yong Lim on 5/21/18.
//  Copyright © 2018 Tee Yong Lim. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem1 = Item()
//        newItem1.title = "Buy Eggos"
//        itemArray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "Destroy Dongky Kong"
//        itemArray.append(newItem2)
//
     //   if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
     //       itemArray = items
            
      //  }
        
      //  loadItems()
    }

    //Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItem()
        
      //  tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Mark - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
           
            
            let newItem = Item(context: self.context)
            
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.append(newItem)
          
//            let encoder = PropertyListEncoder()
//
//
//            do {
//                let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//            } catch
//            {
//                print("Error encoding item array, \(error)")
//            }
//
           self.tableView.reloadData()
            
            self.saveItem()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItem()
    {
        
        
        do {
            try context.save()
            
        } catch
        {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems(){
        
//        if let data = try? Data(contentsOf: dataFilePath!){
//         let decoder = PropertyListDecoder()
//
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
//            }
//            catch{
//                print("Error decoding item, \(error)")
//            }
//
//        }
        
    }
    
}


