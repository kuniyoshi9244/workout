//
//  Log+CoreDataProperties.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/29.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var date: Date?
    @NSManaged public var exercise: Exercise?
    @NSManaged public var records: NSSet?

}

// MARK: Generated accessors for records
extension Log {

    @objc(addRecordsObject:)
    @NSManaged public func addToRecords(_ value: Record)

    @objc(removeRecordsObject:)
    @NSManaged public func removeFromRecords(_ value: Record)

    @objc(addRecords:)
    @NSManaged public func addToRecords(_ values: NSSet)

    @objc(removeRecords:)
    @NSManaged public func removeFromRecords(_ values: NSSet)

}

extension Log : Identifiable {

}
