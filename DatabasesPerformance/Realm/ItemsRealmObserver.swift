//
//  ItemsRealmObserver.swift
//  DatabasesPerformance
//
//  Created by konradjablonskipriv on 02/06/2024.
//

import Foundation
import RealmSwift
import Combine

final class ItemsRealmObserver {
    
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
        
    func observe() -> AnyPublisher<[ItemRealm], Never> {
        try! realm.objects(ItemRealm.self)
            .collectionPublisher
            .map { Array($0) }
            .catch { _ in Just([]) }
            .eraseToAnyPublisher()
    }
}
