//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Tee Yong Lim on 5/28/18.
//  Copyright © 2018 Tee Yong Lim. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
    }
    
    //MARK: TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Categories count is \(categories.count)")
        return categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        print("indexPath number is \(indexPath.row), name is \(cell.textLabel?.text)")
        return cell
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
   
    
    
    //MARK: Data Manipulation Methods
    func saveCategory()
    {
        do {
            try context.save()
            
        } catch
        {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest())
    {
        do{
            categories = try context.fetch(request)
        }catch
        {
            print("error fetching data from context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: Add New Categories
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Category", style: .default) { (action) in
            
           let newCategory = Category(context: self.context)
           newCategory.name = textField.text!
           
            self.categories.append(newCategory)
            
            self.saveCategory()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
       
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //MARK: TableView Delegate Methods
    // write the prepare to Segue delegation methods here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
            
            let destinationVC = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories[indexPath.row]
            }
        
    }
    
    
}
