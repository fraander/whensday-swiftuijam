//
//  Task+CoreDataProperties.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var creationDate: Date?
    @NSManaged public var deadline: Date?
    @NSManaged public var doDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var importance: Bool
    @NSManaged public var title: String?
    
    public var formattedDoDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let formattedDate = dateFormatter.string(from: doDate ?? Date(timeIntervalSince1970: 0))
        return formattedDate
    }
    
    public var formattedDeadline: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let formattedDate = dateFormatter.string(from: deadline ?? Date(timeIntervalSince1970: 0))
        return formattedDate
    }
}

extension Task : Identifiable {

}
