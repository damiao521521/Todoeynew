//
//  myDataModel.swift
//  Todoey
//
//  Created by Jun Miao on 20/12/2017.
//  Copyright © 2017 Jun Miao. All rights reserved.
//

import Foundation

class myDataModel : Encodable,Decodable {
    var myTask : String = ""
    var myDone : Bool = false
}

