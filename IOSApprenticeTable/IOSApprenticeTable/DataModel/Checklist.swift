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
    var iconName = "No Icons"
    var items = [CheckListItem]()
    init(name : String, iconName : String = "No Icon"){
        self.name = name;
        self.iconName = iconName
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
