//
//  realmCategory.swift
//  Todoey
//
//  Created by Jun Miao on 03/01/2018.
//  Copyright © 2018 Jun Miao. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCategory : Object {
    @objc dynamic   var name : String = ""
    let items = List<RealmItem>()
    
}
