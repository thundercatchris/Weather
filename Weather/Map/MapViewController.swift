//
//  ViewController.swift
//  Weather
//
//  Created by Cerebro on 18/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit
import MapKit



class MapViewController: UIViewController, locationsRetreived, MKMapViewDelegate {
    
    let model = MapViewModelController()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        model.delegate = self
        model.getStoredLocations()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        return MapAnnotationCell().getMapAnnotation(annotation: annotation as! CustomPointAnnotation, mapView: mapView)
    }
    
    func getAnnotations() {
        let annotations = MapAnnotations().getAnnotations(locations: model.locations!, mapView: mapView)
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        self.mapView.showAnnotations(annotations, animated: true)
    }
    
    func locationsRetreived() {
        if let locations = model.locations, locations.count > 0 {
            getAnnotations()
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotationSelected = view.annotation as? CustomPointAnnotation, let id = annotationSelected.id {
            self.performSegue(withIdentifier: "showDetail", sender: id)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let nextScene = segue.destination as? DetailViewController,
            let id = sender as? String {
            nextScene.id = id
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
