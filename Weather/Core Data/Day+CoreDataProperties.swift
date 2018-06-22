//
//  Day+CoreDataProperties.swift
//  Weather
//
//  Created by Cerebro on 20/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var day: String?
    @NSManaged public var index: Int16
    @NSManaged public var detail: Detail?
    @NSManaged public var forecast: NSSet?

}

// MARK: Generated accessors for forecast
extension Day {

    @objc(addForecastObject:)
    @NSManaged public func addToForecast(_ value: Forecast)

    @objc(removeForecastObject:)
    @NSManaged public func removeFromForecast(_ value: Forecast)

    @objc(addForecast:)
    @NSManaged public func addToForecast(_ values: NSSet)

    @objc(removeForecast:)
    @NSManaged public func removeFromForecast(_ values: NSSet)

}
