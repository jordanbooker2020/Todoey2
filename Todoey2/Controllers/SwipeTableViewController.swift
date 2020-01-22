//
//  SwipeTableViewController.swift
//  Todoey2
//
//  Created by jbooker2016 on 1/21/20.
//  Copyright © 2020 jbooker2016. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                // handle action by updating model with deletion
                
                print("Delete Cell")
//                if let categoryForDeletion =  self.categoryArray?[indexPath.row] {
//
//                do {
//                    try self.realm.write {
//                        self.realm.delete(categoryForDeletion)
//                    }
//                    } catch {
//                        print("Error deleting category, \(error)")
//                    }
//
//
//                }
//            }
            

            // customize the action appearance
            deleteAction.image = UIImage(named: "delete-icon")

            return [deleteAction]
        }

        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            
            
            return options
        }
       
    }


}

