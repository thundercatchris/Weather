//
//  Detail+CoreDataProperties.swift
//  Weather
//
//  Created by Cerebro on 19/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: String?
    @NSManaged public var day: NSSet?
    @NSManaged public var location: Location?

}

// MARK: Generated accessors for day
extension Detail {

    @objc(addDayObject:)
    @NSManaged public func addToDay(_ value: Day)

    @objc(removeDayObject:)
    @NSManaged public func removeFromDay(_ value: Day)

    @objc(addDay:)
    @NSManaged public func addToDay(_ values: NSSet)

    @objc(removeDay:)
    @NSManaged public func removeFromDay(_ values: NSSet)

}
