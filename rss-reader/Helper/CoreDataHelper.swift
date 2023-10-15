//
//  CoreDataHelper.swift
//  rss-reader
//
//  Created by atriiy on 2023/10/15.
//

import CoreData
import UIKit

class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    private init() {}
    
    var managedContext: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    private var hasPersistentChanges: Bool {
        return !managedContext.insertedObjects.isEmpty ||
            !managedContext.deletedObjects.isEmpty ||
            managedContext.updatedObjects.contains(where: { $0.hasPersistentChangedValues })
    }
    
    func fetch<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T]? {
        let fetchReuqest = NSFetchRequest<T>(entityName: String(describing: entity))
        
        fetchReuqest.predicate = predicate
        fetchReuqest.sortDescriptors = sortDescriptors
        
        do {
            let fetchedResults = try managedContext.fetch(fetchReuqest)
            return fetchedResults
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    @discardableResult func save() throws -> Bool {
        let hasPurpose =
        managedContext.parent != nil ||
        managedContext.persistentStoreCoordinator?.persistentStores.isEmpty == false
        
        guard hasPersistentChanges && hasPurpose else {
            return false
        }
        
        try managedContext.save()
        
        return true
    }
}
