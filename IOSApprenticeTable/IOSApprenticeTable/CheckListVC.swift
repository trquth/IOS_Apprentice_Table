//
//  ViewController.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 3/16/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import UIKit


class CheckListVC: UITableViewController,AddItemDelegate {
    
    var checklist: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //print("Document path ----> \(documentsDirectory())")
        //dataFilePath()
        
        //Load items
        //loadCheckListItems()
        
        navigationItem.largeTitleDisplayMode = .never
        
        title = checklist.name
    }
    
    //MARK: Data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        configureText(for: cell, at: indexPath)
        configureCheckmark(for: cell, with: checklist.items[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item )
            configureText(for: cell, at: indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.items.remove(at: indexPath.row)
        let indexPath = [indexPath]
        tableView.deleteRows(at: indexPath, with: .automatic)
        //saveChecklistItems()
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
        label.text = checklist.items[indexPath.row].text
    }
    
    @IBAction func addItem(){
        let newRowIndex = checklist.items.count
        
        let item = CheckListItem()
        item.text = "F"
        item.checked = false
        
        checklist.items.append(item)
        
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
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    func itemDetailVCDidCancel(_ controller: ItemDetailVC) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailVC(_ controller: ItemDetailVC, didFinishAdding item: CheckListItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
        //saveChecklistItems()
    }
    
    func itemDetailVC(_ controller: ItemDetailVC, didFinishEditing item: CheckListItem) {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, at: indexPath)
            }
        }
        navigationController?.popViewController(animated:true)
        //saveChecklistItems()
    }
    
    //MARK: For file
    //    func documentsDirectory() -> URL {
    //        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //        return paths[0]
    //    }
    //
    //    func dataFilePath() -> URL {
    //        return documentsDirectory().appendingPathComponent("CheckLists.plist")
    //    }
    //
    //    func saveChecklistItems()  {
    //        let encoder = PropertyListEncoder()
    //        do {
    //            let data = try encoder.encode(checklist.items)
    //            try data.write(to: dataFilePath(),  options: Data.WritingOptions.atomic)
    //        } catch  {
    //            print("Error encoding item array : \(error.localizedDescription)")
    //        }
    //    }
    //
    //    func loadCheckListItems() {
    //        let path = dataFilePath()
    //        if let data = try? Data(contentsOf: path) {
    //            let decoder = PropertyListDecoder()
    //            do {
    //                items = try decoder.decode([CheckListItem].self, from: data)
    //            } catch  {
    //                print("Error decoding item array: \(error.localizedDescription)")
    //            }
    //        }
    //    }
    
    
}
