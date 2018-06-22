//
//  CoreDataCalls.swift
//  MajorRoads
//
//  Created by Cerebro on 12/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SWXMLHash

class CoreDataCalls {
    
    var managedContext:NSManagedObjectContext?
    static let sharedInstance: CoreDataCalls = CoreDataCalls()
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func getLocations(completionHandler: @escaping (_ locationObjects: [NSManagedObject]) -> Void) -> Void{
        var locations: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        do {
            locations = (try managedContext?.fetch(fetchRequest))!
            if locations.count > 0 {
                completionHandler(locations)
            } else {
                completionHandler([])
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completionHandler([])
        }
    }
    
    func addLocation(id: String, name: String, lat: String, lon: String, date: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext!)!
        let location = NSManagedObject(entity: entity, insertInto: managedContext)
        location.setValue(id, forKeyPath: "id")
        location.setValue(lat, forKeyPath: "lat")
        location.setValue(lon, forKeyPath: "lon")
        location.setValue(name, forKeyPath: "name")
        location.setValue(date, forKeyPath: "date")
        do {
            try managedContext?.save()
            managedContext?.refreshAllObjects()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteOldLocations() -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try managedContext?.execute(batchDeleteRequest)
            return true
        } catch {
            return false
        }
    }
    
    func deleteOldDetails(id: String, completionHandler: @escaping (_ complete: Bool) -> Void) -> Void{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Detail")
        var details: [NSManagedObject] = []
        do {
            details = (try managedContext?.fetch(fetchRequest))!
            if details.count > 0 {
                loopThroughOldDetailsResults(id: id, details: details, completionHandler: { (complete) in
                    completionHandler(complete)
                })
            } else {
                completionHandler(true)
            }
        } catch let error as NSError {
            completionHandler(false)
            print("Could not delete. \(error), \(error.userInfo)")
        }
        
    }
    
    private func loopThroughOldDetailsResults(id: String, details: [NSManagedObject], completionHandler: @escaping (_ complete: Bool) -> Void) -> Void{
        for i in 0...(details.count - 1) {
            let detail = (details as [NSManagedObject])[i]
            if let detailId = (detail.value(forKey: "id") as? String), detailId == id {
                managedContext?.delete(detail)
                do {
                    try managedContext?.save()
                    managedContext?.refreshAllObjects()
                    completionHandler(true)
                } catch let error as NSError {
                    completionHandler(false)
                    print("Could not delete. \(error), \(error.userInfo)")
                }
                completionHandler(true)
            }
            if i == (details.count - 1) {
                completionHandler(true)
            }
        }
    }
    
    func getDetail(id:String, completionHandler: @escaping (_ locationObjects: Detail?) -> Void) -> Void{
        var details: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Detail")
        do {
            details = (try managedContext?.fetch(fetchRequest))!
            if details.count > 0 {
                for i in 0...(details.count - 1) {
                    if let detail = details[i] as? Detail {
                        if detail.id == id {
                            completionHandler(detail)
                            break
                        }
                        if i == (details.count - 1) {
                            completionHandler(nil)
                        }
                    }
                }
            } else {
                completionHandler(nil)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completionHandler(nil)
        }
    }
    
    
}
