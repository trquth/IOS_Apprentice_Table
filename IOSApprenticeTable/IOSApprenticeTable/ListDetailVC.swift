//
//  ListDetailVC.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 4/2/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import UIKit

protocol ListDetailVCDelegate: class {
    func listDetailVCDidCancel(_ controller : ListDetailVC)
    func listDetailVC(_ controller : ListDetailVC, didFinishAdding checklist : Checklist)
    func listDetailVC(_ controller: ListDetailVC, didFinishEditing checklist : Checklist)
}

class ListDetailVC: UITableViewController,  UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate : ListDetailVCDelegate?
    var checkListToEdit : Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let checklist = checkListToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        doneBarButton.isEnabled = false
//        return true
//    }
    

    @IBAction func cancel() {
        delegate?.listDetailVCDidCancel(self)
    }
    
    @IBAction func done() {
        if let checklist = checkListToEdit {
                  checklist.name = textField.text!
                  delegate?.listDetailVC(self, didFinishEditing: checklist)
              }else{
                  let checklist = Checklist(name: textField.text!)
                  delegate?.listDetailVC(self, didFinishAdding: checklist)
              }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         
         let oldText = textField.text!
         let stringRange = Range(range, in:oldText)!
         let newText = oldText.replacingCharacters(in: stringRange, with: string)
         doneBarButton.isEnabled = !newText.isEmpty
         return true
       }
       
}
