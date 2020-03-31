//
//  ViewController.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 3/16/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import UIKit


class CheckListVC: UITableViewController,AddItemDelegate {
    
    var items = [CheckListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let item = CheckListItem()
        item.text = "A"
        items.append(item)
        
        let item2 = CheckListItem()
        item2.text = "B"
        items.append(item2)
        
        let item3 = CheckListItem()
        item3.text = "C"
        items.append(item3)
        
        let item4 = CheckListItem()
        item4.text = "D"
        items.append(item4)
        
        let item5 = CheckListItem()
        item5.text = "E"
        items.append(item5)
        
    }
    
    //MARK: Data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        configureText(for: cell, at: indexPath)
        configureCheckmark(for: cell, with: items[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item )
            configureText(for: cell, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPath = [indexPath]
        tableView.deleteRows(at: indexPath, with: .automatic)
    }
    
    //MARK:- Private method
    func configureCheckmark(for cell: UITableViewCell, with item: CheckListItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text  = "√"
        }else{
            label.text  = ""
        }
    }
    
    func configureText(for cell : UITableViewCell, at indexPath : IndexPath) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = items[indexPath.row].text
    }
    
    @IBAction func addItem(){
        let newRowIndex = items.count
        
        let item = CheckListItem()
        item.text = "F"
        item.checked = false
        
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailVC
            controller.delegate = self
        }else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailVC
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    func itemDetailVCDidCancel(_ controller: ItemDetailVC) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailVC(_ controller: ItemDetailVC, didFinishAdding item: CheckListItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailVC(_ controller: ItemDetailVC, didFinishEditing item: CheckListItem) {
      if let index = items.index(of: item) {
             let indexPath = IndexPath(row: index, section: 0)
             if let cell = tableView.cellForRow(at: indexPath) {
               configureText(for: cell, at: indexPath)
             }
           }
           navigationController?.popViewController(animated:true)
    }

    
}
