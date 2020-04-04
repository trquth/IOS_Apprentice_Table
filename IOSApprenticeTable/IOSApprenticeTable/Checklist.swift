//
//  Checklist.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 3/31/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import Foundation

class Checklist: NSObject, Codable {
    var name = ""
    var items = [CheckListItem]()
    init(name : String){
        self.name = name;
        super.init()
    }
}
