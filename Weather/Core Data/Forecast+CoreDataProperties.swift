//
//  Forecast+CoreDataProperties.swift
//  Weather
//
//  Created by Cerebro on 20/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//
//

import Foundation
import CoreData


extension Forecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Forecast> {
        return NSFetchRequest<Forecast>(entityName: "Forecast")
    }

    @NSManaged public var index: Int16
    @NSManaged public var significantweather: String?
    @NSManaged public var screentemp: String?
    @NSManaged public var precipitation: String?
    @NSManaged public var wind: String?
    @NSManaged public var day: Day?

}
