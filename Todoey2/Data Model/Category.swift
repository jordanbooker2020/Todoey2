//
//  Category.swift
//  Todoey2
//
//  Created by jbooker2016 on 1/11/20.
//  Copyright © 2020 jbooker2016. All rights reserved.
//

import Foundation
import RealmSwift

//object allows you to save data using realm
class Category: Object {
    // dynamic allows you to monitor for changes in name property
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
