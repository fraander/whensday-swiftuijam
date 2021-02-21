//
//  Persistence.swift
//  Core Data Template
//
//  Created by Frank on 2/18/21.
//

import CoreData
import Foundation

struct PersistenceController {
    static var shared = PersistenceController()
    
    let container: NSPersistentContainer
    lazy var context = container.viewContext
    
    init() {
        container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
