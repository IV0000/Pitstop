//
//  Vehicle+CoreDataProperties.swift
//  Hurricane
//
//  Created by Ivan Voloshchuk on 05/05/22.
//
//

import Foundation
import CoreData


extension Vehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }

    @NSManaged public var brand: String?
    @NSManaged public var document: Data?
    @NSManaged public var fuelType: Int32
    @NSManaged public var model: String?
    @NSManaged public var name: String?
    @NSManaged public var odometer: Int16
    @NSManaged public var plate: String?
    @NSManaged public var vehicleID: UUID?
    @NSManaged public var year: Int16
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension Vehicle {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

extension Vehicle : Identifiable {

}