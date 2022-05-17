//
//  Expense+CoreDataProperties.swift
//  Hurricane
//
//  Created by Ivan Voloshchuk on 05/05/22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var odometer: Int32
    @NSManaged public var price: Float
    @NSManaged public var category: Int16
    @NSManaged public var vehicle: Vehicle?

}

extension Expense : Identifiable {

}
