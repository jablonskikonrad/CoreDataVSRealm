//
//  ItemCoreDataCreator.swift
//  DatabasesPerformance
//
//  Created by konradjablonskipriv on 02/06/2024.
//

import Foundation
import CoreData

final class ItemCoreDataCreator {
    
    func addItem() {
        let context = ItemCoreDataStack.shared.context
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context)
        newItem.setValue(Date(), forKey: "timestamp")
        newItem.setValue(Date(), forKey: "timestamp2")
        newItem.setValue(Date(), forKey: "timestamp3")
        newItem.setValue(Date(), forKey: "timestamp4")
        newItem.setValue(Date(), forKey: "timestamp5")
        newItem.setValue(Date(), forKey: "timestamp6")
        
        do {
            try context.save()
//            print("Item saved successfully.")
        } catch {
            print("Failed to save item: \(error)")
        }
    }
}
