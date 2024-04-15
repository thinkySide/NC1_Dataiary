//
//  CoreDataDiary+CoreDataProperties.swift
//  Dataiary
//
//  Created by 김민준 on 4/15/24.
//
//

import Foundation
import CoreData

extension CoreDataDiary {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataDiary> {
        return NSFetchRequest<CoreDataDiary>(entityName: "CoreDataDiary")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var content: String
    
}

extension CoreDataDiary: Identifiable {
    
}
