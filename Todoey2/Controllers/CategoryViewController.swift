 //
//  CategoryViewController.swift
//  Todoey2
//
//  Created by jbooker2016 on 12/28/19.
//  Copyright © 2019 jbooker2016. All rights reserved.
//

import UIKit
import RealmSwift

 
// When using delegates it is usually a good idea to use extension
 class CategoryViewController: SwipeTableViewController {
    // initizing access point to realm database
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    // change our category array to a collection of results, its an optional(?)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.rowHeight = 80.0
        
    }

   // MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
        //return the number of categories if there are any and if not return 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added Yet"
        // the cell is going to have a text label if we have categories and if not it will put in a cell "No Categories Added"
        cell.delegate = self
        
        return cell
        
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        // this is if we select the category row the segue that will take the user to the TodoListViewControllwe
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        // creating a new instance of destinationVC
    if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCategory = categoryArray?[indexPath.row]
        /* We set the destinationVC to the selected category  indexPath.row that was
        selected which triggers segue which then takes us to the todolistViewController*/
    }
    }

    //MARK - Data Manipulation Methods
    func save(category: Category) {
        //we pass in the new category that we created
        do {
//            try context.save()
            try realm.write {
                //realm.write commits changes to realm
                realm.add(category)
                //we want to add our new category to realm database
            }
        } catch {
            print("Error saving category \(error)")
            // log if there are errors
        }
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
         categoryArray = realm.objects(Category.self)
        // we set our results container to look inside our realm and fetch all of the objects that belong to the category data type
        tableView.reloadData()
        // reloads table view with new data, it calls all the "Tableview DataSource Methods again"
//
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
//            let newCategory = Category(context: self.context)
            let newCategory = Category()
            // creating a new category object
            newCategory.name = textField.text!
            // we give a category a new name based on what the user types in the text field
            
          //  self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
            // calling save method to save the new category to realm database
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated:  true, completion: nil)
    }
    
}
 
 
 
 
 
 
