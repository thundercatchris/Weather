//
//  MapViewModelController.swift
//  Weather
//
//  Created by Cerebro on 19/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

protocol locationsRetreived {
    func locationsRetreived()
}

class MapViewModelController {
    
    let coreData = CoreDataCalls.sharedInstance
    var delegate:locationsRetreived? = nil
    var locations:[NSManagedObject]?
    
    func getStoredLocations() {
        coreData.getLocations { (locations) in
            self.locations = locations
            if self.detailsAreWithin24Hours() {
                self.delegate?.locationsRetreived()
            } else {
                self.clearOldLocations()
            }
        }
    }
    
    func detailsAreWithin24Hours() -> Bool {
        if let storedLocations = locations, storedLocations.count > 0, let dateString = storedLocations.first?.value(forKey: "date") as? String {
            return DateHelper().detailsAreWithinLast24Hours(dateString: dateString)
        } else {
            return false
        }
    }
    
    func clearOldLocations() {
        if coreData.deleteOldLocations() {
            locations = nil
            getNewLocations()
        } else {
            print("error deleting locations")
        }
    }
    
    func getNewLocations() {
        let network = NetworkRequest()
        network.locationsRequest { (result) in
            if result.isSuccess {
                self.formatLocations(result: result)
            } else {
                print(result.error ?? "failed to download locations")
            }
        }
    }
    
    func formatLocations(result: Result<String>?) {
        let xml = LocationsFromXML()
        xml.locationsFromXML(result: result!) { (complete) in
            self.getStoredLocations()
        }
    }
}
