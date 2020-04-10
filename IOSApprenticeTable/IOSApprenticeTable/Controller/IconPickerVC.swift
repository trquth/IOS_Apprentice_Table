//
//  IconPickerVC.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 4/9/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import UIKit

protocol IconPickerVCDelegate : class {
    func iconPicker(_ picker : IconPickerVC , didPick iconName: String)
}

class IconPickerVC: UITableViewController {
    
    let icons = [ "No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips" ]
    
    weak var delegate : IconPickerVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        let iconName = icons[indexPath.row]
        cell.textLabel?.text = iconName
        cell.imageView?.image = UIImage(named: iconName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPick: iconName)
        }
    }

}
