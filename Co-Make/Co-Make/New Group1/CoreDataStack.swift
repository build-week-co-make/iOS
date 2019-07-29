//
//  CoreDataStack.swift
//  Co-Make
//
//  Created by Kat Milton on 7/29/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        
        if let error = error {
            throw error
        }
    }
    
    lazy var container: NSPersistentContainer = {
        
        // Give the container the name of your data model file
        let container = NSPersistentContainer(name: "Co-Make")
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                
                // Crashes app and logs the nature of the error.
                fatalError("Failed to load persistent stores: \(error)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    // This should help you remember to use the viewContext on the main thread only.
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    
    
}
