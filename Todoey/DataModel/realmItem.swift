//
//  realmItem.swift
//  Todoey
//
//  Created by Jun Miao on 03/01/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import Foundation
import RealmSwift

class RealmItem : Object {
 @objc dynamic   var title : String = ""
 @objc dynamic    var done : Bool = false
    
   @objc dynamic var createAt = Date()

    var parentRealmCategory = LinkingObjects(fromType: RealmCategory.self, property: "items")
    
}
