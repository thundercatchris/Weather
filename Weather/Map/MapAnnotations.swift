//
//  MapAnnotations.swift
//  PokeGym
//
//  Created by Cerebro on 08/02/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import MapKit
import CoreData

class MapAnnotations {
    
    func getAnnotations(locations: [NSManagedObject], mapView: MKMapView) -> [MKAnnotation] {
        var annotations = [MKAnnotation]()
        for location in locations {
            if let latString = location.value(forKey: "lat") as? String, let lat = Double(latString),
                let lonString = location.value(forKey: "lon") as? String, let lon = Double(lonString),
                let name = location.value(forKey: "name") as? String,
                let id = location.value(forKey: "id") as? String{
                let annotation = CustomPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                annotation.title = name
                annotation.id = id
                annotation.subtitle = ""
                annotations.append(annotation)
            }
        }
        return annotations
    }
    
    
}
