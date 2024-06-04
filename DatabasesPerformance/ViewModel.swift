//
//  ViewModel.swift
//  DatabasesPerformance
//
//  Created by konradjablonskipriv on 02/06/2024.
//

import Foundation
import Combine
import RealmSwift

final class DatabasePerformanceViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    static let numberOfTests = 10000
    
    init() {
        measurePerformance()
    }
    
    func measurePerformance() {
        RealmCleaner.clearAllData()
        ItemsCoreDataCleaner.clearAllData()

        measureCoreDataPerformance()
        measureRealmPerformance()
    }
    
    private func measureCoreDataPerformance() {
        let coreDataPublisher = ItemsCoreDataObserver(context: ItemCoreDataStack.shared.context)
        let startTime = CFAbsoluteTimeGetCurrent()
        
        coreDataPublisher.itemsPublisher()
            .sink { items in
                if items.count == Self.numberOfTests {
                    let endTime = CFAbsoluteTimeGetCurrent()
                    let timeElapsed = endTime - startTime
                    print("Core Data: Time elapsed to receive \(String(Self.numberOfTests))th item: \(timeElapsed) seconds")
                }
            }
            .store(in: &cancellables)
        
        for i in 1...Self.numberOfTests {
            ItemCoreDataCreator().addItem()
        }
        ItemCoreDataStack.shared.saveContext()
    }
    
    private func measureRealmPerformance() {
        let realm = try! Realm()
        let realmItemPublisher = ItemsRealmObserver(realm: realm)
        let startTime = CFAbsoluteTimeGetCurrent()
        
        realmItemPublisher.observe()
            .sink { items in
                if items.count == Self.numberOfTests {
                    let endTime = CFAbsoluteTimeGetCurrent()
                    let timeElapsed = endTime - startTime
                    print("Realm: Time elapsed to receive \(String(Self.numberOfTests)) item: \(timeElapsed) seconds")
                }
            }
            .store(in: &cancellables)
        
        for i in 1...Self.numberOfTests {
            ItemRealmCreator(realm: realm).addItem()
        }
    }
}
