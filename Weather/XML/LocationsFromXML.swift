//
//  XMLParser.swift
//  Weather
//
//  Created by Cerebro on 19/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import SWXMLHash
import Alamofire

class LocationsFromXML {
    
    let coreData = CoreDataCalls.sharedInstance
    
    func locationsFromXML(result: Result<String>, completionHandler: @escaping (_ complete: Bool) -> Void) {
        let xml = SWXMLHash.parse(result.value!)
        let xmlAll = xml["Locations"]["Location"].all
        
        for i in 0...(xmlAll.count - 1) {
            if let dict = xmlAll[i].element?.allAttributes,
                let name = dict["name"]?.text,
                let id = dict["id"]?.text,
                let lat = dict["latitude"]?.text,
                let lon = dict["longitude"]?.text {
                let date = DateHelper().stringFromDate(date: Date(), format:  "yyyy-MM-dd-HH:mm")
                
                coreData.addLocation(id: id, name: name, lat: lat, lon: lon, date: date)
                if i == (xmlAll.count - 1) {
                    completionHandler(true)
                }
            }
        }
        
    }
    

    
}

