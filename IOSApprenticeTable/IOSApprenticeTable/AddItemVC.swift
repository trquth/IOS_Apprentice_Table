//
//  AddItemVC.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 3/18/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import UIKit

protocol AddItemDelegate : class {
    func itemDetailVCDidCancel(_ controller : ItemDetailVC)
    func itemDetailVC(_ controller : ItemDetailVC, didFinishAdding item: CheckListItem)
    func itemDetailVC(_ controller : ItemDetailVC, didFinishEditing item: CheckListItem)
}

class ItemDetailVC: UITableViewController , UITextFieldDelegate{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate : AddItemDelegate?
    var itemToEdit: CheckListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit {
            item.text = textField.text!;
            delegate?.itemDetailVC(self, didFinishEditing: item)
        }else{
            let item = CheckListItem()
            item.text = textField.text!;
            delegate?.itemDetailVC(self, didFinishAdding: item)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailVCDidCancel(self);
    }
}
