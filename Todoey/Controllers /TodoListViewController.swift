//
//  ViewController.swift
//  Todoey
//
//  Created by Mohamed Samy on 7/19/20.
//  Copyright © 2020 Mohamed Samy. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            //loadItems()
        }
    }
    
    
           
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
        // Do any additional setup after loading the view.

        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done == true ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                //realm.delete(item)
                item.done = !item.done
            }
            }catch {
                print("error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        
        //print(itemArray[indexPath.row])
        
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        
      
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when the user clicks the add item button
           
            if let currentCategory = self.selectedCategory {
               
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                        newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }

                } catch {
                    print("Error saving new item, \(error)")
                }
                //newItem.parentCategory = self.selectedCategory
                // self.itemArray.append(newItem)
        }
            self.tableView.reloadData()
            
            
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        
    }
    
//    func saveItems() {
//
//                   do {
//                    try realm.write {
//                        realm.add(Category)
//                    }
//
//                   } catch {
//                       print("Error saving to category, \(error)")
//                   }
//
//
//                   self.tableView.reloadData()
    }
    
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
        
    }
}
//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
        todoItems = todoItems?.filter("title CONTAINS [cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        

        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
    }

