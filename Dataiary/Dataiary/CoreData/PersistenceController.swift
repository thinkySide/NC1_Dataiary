//
//  PersistenceController.swift
//  Dataiary
//
//  Created by 김민준 on 4/15/24.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        
        // xcdatamodeld 파일명과 같아야함
        container = NSPersistentContainer(name: "CoreDataModel")
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Cannot Load PersistentStores: \(error)")
            }
        }
    }
}
