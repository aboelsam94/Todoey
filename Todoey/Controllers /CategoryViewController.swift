//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mohamed Samy on 8/5/20.
//  Copyright © 2020 Mohamed Samy. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

    loadCategories()
    }
        //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            cell.textLabel?.text = categories[indexPath.row].name
            return cell
            
        }
           
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as!TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    
    
        
        
        
        //MARK - Data Manipulation Methods
        func saveCategories() {
            
            do {
            try context.save()
            } catch {
                print("Error saving category, \(error)")
            }
            self.tableView.reloadData()
        }
        
        func loadCategories() {
            let request : NSFetchRequest<Category> = Category.fetchRequest()
            do {
               categories = try context.fetch(request)
            } catch {
                print("Error loading, \(error)")
        
            }
            self.tableView.reloadData()
        }
        
    
    
    @IBAction func addSelected(_ sender: UIBarButtonItem) {
        
        
            var textfield = UITextField()
            let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add", style: .default) { (action) in
                
                let newCategory = Category(context: self.context)
                
                newCategory.name = textfield.text!
                
                self.categories.append(newCategory)
                
                self.saveCategories()
                
            }
            
            alert.addAction(action)
            
            alert.addTextField { (field) in
                textfield.placeholder = "Add a new category"
                textfield = field
            }
            present(alert, animated: true, completion: nil)
        }

    }
  
    

    
    
    
    
    
    
    
    
    
    

