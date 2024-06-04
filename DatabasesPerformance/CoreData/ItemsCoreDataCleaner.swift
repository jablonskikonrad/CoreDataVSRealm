//
//  ItemsCoreDataCleaner.swift
//  DatabasesPerformance
//
//  Created by konradjablonskipriv on 02/06/2024.
//

import Foundation
import CoreData

class ItemsCoreDataCleaner {
    static func clearAllData() {
        let context = ItemCoreDataStack.shared.context
        let entityNames = ItemCoreDataStack.shared.persistentContainer.managedObjectModel.entities.map { $0.name! }
        
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
                try context.save()
            } catch {
                print("Failed to clear data for entity \(entityName): \(error)")
            }
        }
    }
}
