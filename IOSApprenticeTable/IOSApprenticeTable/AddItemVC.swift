//
//  AddItemVC.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 3/18/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import UIKit

class AddItemVC: UITableViewController , UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
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
            doneBarBtn.isEnabled = false
        }else{
            doneBarBtn.isEnabled = true
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarBtn.isEnabled = false
        return true
    }
    
    @IBAction func done(_ sender: Any) {
        
    }
}
