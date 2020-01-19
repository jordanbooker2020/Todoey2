//
//  Item.swift
//  Todoey2
//
//  Created by jbooker2016 on 1/11/20.
//  Copyright © 2020 jbooker2016. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    //property relates to let items = List<Item>()
}
