//
//  ItemRealmCreator.swift
//  DatabasesPerformance
//
//  Created by konradjablonskipriv on 02/06/2024.
//

import Foundation
import RealmSwift

final class ItemRealmCreator {
        
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func addItem() {
        let item = ItemRealm()
        item.timestamp = Date()
        
        do {
            try realm.write {
                realm.add(item)
            }
//            print("Item saved successfully.")
        } catch {
            print("Failed to save item: \(error)")
        }
    }
}
