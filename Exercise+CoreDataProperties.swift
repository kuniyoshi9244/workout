//
//  Exercise+CoreDataProperties.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/29.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var order: Int16
    @NSManaged public var logs: NSSet?
    @NSManaged public var region: Region?
    @NSManaged public var type: Type?

}

// MARK: Generated accessors for logs
extension Exercise {

    @objc(addLogsObject:)
    @NSManaged public func addToLogs(_ value: Log)

    @objc(removeLogsObject:)
    @NSManaged public func removeFromLogs(_ value: Log)

    @objc(addLogs:)
    @NSManaged public func addToLogs(_ values: NSSet)

    @objc(removeLogs:)
    @NSManaged public func removeFromLogs(_ values: NSSet)

}

extension Exercise : Identifiable {

}
