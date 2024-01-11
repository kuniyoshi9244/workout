//
//  Region+CoreDataProperties.swift
//  workout
//
//  Created by 國吉宏一郎 on 2023/08/29.
//
//

import Foundation
import CoreData


extension Region {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Region> {
        return NSFetchRequest<Region>(entityName: "Region")
    }

    @NSManaged public var name: String?
    @NSManaged public var order: Int16
    @NSManaged public var exercises: NSSet?

}

// MARK: Generated accessors for exercises
extension Region {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Region : Identifiable {

}
