//
//  DataModel.swift
//  IOSApprenticeTable
//
//  Created by Thien Tran on 4/5/20.
//  Copyright © 2020 Thien Tran. All rights reserved.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    
    init() {
        loadChecklists()
        registerDefaults()
    }
    
    //MARK: For file
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("CheckLists.plist")
    }
    
    func saveChecklists()  {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(),  options: Data.WritingOptions.atomic)
        } catch  {
            print("Error encoding list array : \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        print("Path \(path)")
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
            } catch  {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }
    
    func registerDefaults() {
        let dictionary = ["ChecklistIndex" : -1]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    var indexOfSelectedChecklist : Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    func sortChecklists() {
        lists.sort(by: {list1, list2 in return list1.name.localizedStandardCompare(list2.name) == .orderedAscending})
    }
}
