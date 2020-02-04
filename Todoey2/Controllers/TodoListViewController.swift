//
//  ViewController.swift
//  Todoey2
//
//  Created by jbooker2016 on 12/19/19.
//  Copyright © 2019 jbooker2016. All rights reserved.
//
//
//

import UIKit
import RealmSwift


class TodoListViewController: SwipeTableViewController {

    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
        loadItems()
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        // loadItems(with: request)
    
    }
    
    
    
    //MARK Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
        // saying we should have as many cells as todo items, if there arent enough just return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            //saying the cell is going to have a text label based on the items title
                   
            cell.accessoryType = item.done == true ? .checkmark : .none
            // if item .done property is true then add a checkmark otherwise nothing
        } else {
            cell.textLabel?.text = "No Items Added"
            // if there are no todo items then say "no items added"
            // this is correlated to the 1 cell created  in method above
        }
        
        
       
        return cell
    }
    
    //MARK - TableView Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    
                   item.done = !item.done
                }
            } catch {
                print("Error saving done  status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - Add New Items
        
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Study Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the add item button to our UIAlert
            
            
                
        if let currentCategory = self.selectedCategory {
            // if selectedCategory is not nil because it is an optional make it equal currentCategory
            do {
                try self.realm.write {
                    // we try to update our realm by creating a new Item object
                let newItem = Item()
                newItem.title = textField.text!
                    // setting newItems  title
                newItem.dateCreated = Date()
                    //setting the date for the newItem to the current date
                currentCategory.items.append(newItem)
                    //appending newItem to the currentCategory
                }
            } catch {
                print("Error saving new items, \(error)")
                    }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
   
    
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                    print("Error delete Item, \(error)")
                }
            }
        }
    }
    
    
    
    

//MARK
extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
        

    

    // Gets rid of search bar typing thing and makes keyboard go away
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }


        }

    }
    

    

}

