//
//  Record+CoreDataProperties.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/29.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var rep: Int16
    @NSManaged public var set: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var log: Log?

}

extension Record : Identifiable {

}
