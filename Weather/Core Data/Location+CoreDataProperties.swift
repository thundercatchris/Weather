//
//  Location+CoreDataProperties.swift
//  Weather
//
//  Created by Cerebro on 20/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var id: String?
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var name: String?
    @NSManaged public var date: String?
    @NSManaged public var detail: Detail?

}
