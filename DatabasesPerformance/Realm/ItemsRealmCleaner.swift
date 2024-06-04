//
//  ItemsRealmCleaner.swift
//  DatabasesPerformance
//
//  Created by konradjablonskipriv on 02/06/2024.
//

import Foundation
import RealmSwift

final class RealmCleaner {
    static func clearAllData() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
}
