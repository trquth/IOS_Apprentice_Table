//
//  CheckListItem.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 3/17/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import Foundation

class CheckListItem {
    var text = "";
    var checked = false;
    
    func toggleChecked() {
        checked = !checked
    }
}
