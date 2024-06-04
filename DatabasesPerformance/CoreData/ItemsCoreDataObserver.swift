//
//  ItemsCoreDataObserver.swift
//  DatabasesPerformance
//
//  Created by konradjablonskipriv on 02/06/2024.
//

import Foundation
import Combine
import CoreData

final class ItemsCoreDataObserver: NSObject, NSFetchedResultsControllerDelegate {
    
    private let context: NSManagedObjectContext
    private let fetchRequest: NSFetchRequest<Item>
    private let subject = PassthroughSubject<[Item], Never>()
    
    private var fetchedResultsController: NSFetchedResultsController<Item>!
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.fetchRequest = Item.fetchRequest()
        super.init()
        configureFetchedResultsController()
    }
    
    private func configureFetchedResultsController() {
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            if let items = fetchedResultsController.fetchedObjects {
                subject.send(items)
            }
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let items = fetchedResultsController.fetchedObjects {
            subject.send(items)
        }
    }
    
    func itemsPublisher() -> AnyPublisher<[Item], Never> {
        return subject.eraseToAnyPublisher()
    }
}
