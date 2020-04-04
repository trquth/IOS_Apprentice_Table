//
//  AllListsVC.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 3/31/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import UIKit

class AllListsVC: UITableViewController, ListDetailVCDelegate {
    func listDetailVCDidCancel(_ controller: ListDetailVC) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailVC(_ controller: ListDetailVC, didFinishAdding checklist: Checklist) {
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailVC(_ controller: ListDetailVC, didFinishEditing checklist: Checklist) {
        if let index = dataModel.lists.firstIndex(of: checklist){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    let cellIdentifier = "ChecklistCell"
    var dataModel : DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }
    
    
    func makeCell(for tableView : UITableView) -> UITableViewCell {
        let cellIdentifier = "Cell"
        if let cell  = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        }else{
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = makeCell(for: tableView)
        
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel?.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
               let indexPaths =  [indexPath]
               tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "ListDetailVC") as! ListDetailVC
        controller.delegate = self
        let checklist = dataModel.lists[indexPath.row]
        controller.checkListToEdit = checklist
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destination as! CheckListVC
            controller.checklist = sender as? Checklist 
        }else if segue.identifier == "AddChecklist" {
            let controller = segue.destination as! ListDetailVC
            controller.delegate = self
            
        }
    }
}
