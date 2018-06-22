//
//  DetailFromXML.swift
//  Weather
//
//  Created by Cerebro on 20/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import CoreData
import SWXMLHash
import Alamofire

class DetailFromXML {
    
    let coreData = CoreDataCalls.sharedInstance
    
    func detailFromXML(location: Result<String>, id: String, date: String, completionHandler: @escaping (_ complete: Bool) -> Void) -> Void{
        
        let xml = SWXMLHash.parse(location.value!)
        let days = xml["SiteRep"]["DV"]["Location"]["Period"].all
        let dateString = DateHelper().stringFromDate(date: Date(), format: "yyyy-MM-dd-HH:mm")
        let context = coreData.managedContext
        
        let detail = Detail(context: context!)
        detail.id = id
        detail.date = dateString
        
        createDays(days: days, context: context!) { (day) in
            if let day = day {
                detail.addToDay(day)
            }
        }
        
        do {
            try context?.save()
            context?.refreshAllObjects()
            completionHandler(true)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completionHandler(false)
        }
        
    }
    
    func createDays(days:  [XMLIndexer], context: NSManagedObjectContext, completionHandler: @escaping (_ Forecast: Day?) -> Void) {
        let daysCount = days.count
        if daysCount >= 1 {
            for i in 0...(daysCount - 1) {
                let day = days[i]
                var date = day.element?.allAttributes["value"]?.text
                date?.removeLast()
                
                let dayEntity = Day(context: context)
                dayEntity.day = date
                dayEntity.index = Int16(i)
                if let forecasts = day.element?.children {
                    
                    createForecasts(forecasts: forecasts, day: day, context: context, completionHandler: { (forecast) in
                        if let forecast = forecast {
                            dayEntity.addToForecast(forecast)
                        }
                    })
                }
                completionHandler(dayEntity)
            }
        }
        completionHandler(nil)
    }
    
    func createForecasts(forecasts:  [XMLContent], day: XMLIndexer, context: NSManagedObjectContext, completionHandler: @escaping (_ forecast: Forecast?) -> Void) {
        if forecasts.count >= 1 {
            for i in 0...(forecasts.count - 1) {
                if let weatherSlot = day["Rep"][i].element?.allAttributes {
                    let forecast = Forecast(context: context)
                    forecast.index = Int16(i)
                    for (key, value) in weatherSlot {
                        if key == "W" { forecast.significantweather = value.text }
                        if key == "T" { forecast.screentemp = value.text }
                        if key == "Pp" { forecast.precipitation = value.text }
                        if key == "S" { forecast.wind = value.text }
                        forecast.index = Int16(i)
                    }
                    completionHandler(forecast)
                }
            }
        }
        completionHandler(nil)
    }
    
}
