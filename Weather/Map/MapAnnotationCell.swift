//
//  MapAnnotation.swift
//  PokeGym
//
//  Created by Cerebro on 08/02/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var id: String!
}
class MapAnnotationCell {

    func getMapAnnotation(annotation: CustomPointAnnotation, mapView: MKMapView) -> MKAnnotationView {
        let reuseId = "weather"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        } else {
            anView?.annotation = annotation
        }
        anView?.image = UIImage(named:"weatherPin")
        anView?.frame.size = CGSize(width: 30.0, height: 30)
        
        let btn = UIButton(type: .detailDisclosure)
        btn.setImage(UIImage(named: "disclosure"), for: .normal)
        anView?.rightCalloutAccessoryView = btn

        return anView!
    }
    
}
