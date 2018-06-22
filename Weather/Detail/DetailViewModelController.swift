//
//  DetailViewModelController.swift
//  Weather
//
//  Created by Cerebro on 20/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

protocol DetailsRetreived {
    func DetailsRetreived()
}

class DetailViewModelController {
    
    let coreData = CoreDataCalls.sharedInstance
    var delegate:DetailsRetreived? = nil
    var detail:Detail?
    var id:String!
    var days:[String?]?
    var forecasts:[[Forecast?]]?
    
    init(id:String) {
        self.id = id
    }
    
    func getStoredDetails() {
        coreData.getDetail(id: id) { (detail) in
            self.detail = detail
            if detail == nil {
                self.getNewDetails()
            } else {
                if self.detailsAreWithin24Hours() {
                    self.sortData()
                } else {
                    self.clearOldDetails()
                }
            }
        }
    }
    
    func detailsAreWithin24Hours() -> Bool {
        if let storedDetail = detail, let dateString = storedDetail.date {
            return DateHelper().detailsAreWithinLast24Hours(dateString: dateString)
        } else {
            return false
        }
    }
    
    func clearOldDetails() {
        coreData.deleteOldDetails(id: id!, completionHandler: { (complete) in
            if complete {
                self.detail = nil
                self.getNewDetails()
            } else {
                print("error") // error message
            }
        })
    }
    
    func getNewDetails() {
        let network = NetworkRequest()
        network.locationDetailRequest(locationId: id) { (result) in
            if result.isSuccess {
                self.formatDetails(location: result)
            } else {
                print(result.error ?? "failed to download locations")
            }
        }
    }
    
    func formatDetails(location: Result<String>?) {
        let xml = DetailFromXML()
        let date = DateHelper().stringFromDate(date: Date(), format: "yyyy-MM-dd-HH:mm")
        xml.detailFromXML(location: location!, id: id, date: date) { (complete) in
            self.getStoredDetails()
        }
    }
    
    func sortData() {
        
        createEmptyArrays()
        
        if let days = detail?.day {
            for day in days {
                if let day = day as? Day, let date = day.day, let forecastsPerDay = day.forecast {
                    let index = Int(day.index)
                    if let daysTotal = self.days?.count, daysTotal >= (index - 1) {
                        if let dateFormatted = DateHelper().reformatDateString(dateString: date, oldFormat: "yyyy-MM-dd", newFormat: "dd MMM") {
                             self.days?[index] = dateFormatted
                        }
                        sortForecasts(forecastsPerDay: forecastsPerDay, index: index)
                    }
                }
            }
        }
    }
    
    func sortForecasts(forecastsPerDay: NSSet, index: Int ) {
        var tempForecasts = createEmptyForecastsPerDay(forecastsPerDay: forecastsPerDay.count)
        var i = 0
        for forecast in forecastsPerDay {
            if let forecast = forecast as? Forecast {
                i = i + 1
                let dayForecastindex = Int(forecast.index)
                tempForecasts[dayForecastindex] = forecast // add at correct index
                if i == forecastsPerDay.count { // if end of the loop
                    if let count = self.forecasts?.count, count > 0, count >= index {
                        self.forecasts![index] = tempForecasts // add at correct index
                        self.delegate?.DetailsRetreived()
                    }
                }
            }
        }
    }
    
    func createEmptyArrays() {
        let dayCount = 5
        var daysSetup = [String?]()
        var forecastsSetup = [[Forecast?]]()
        for _ in 0...(dayCount - 1) {
            daysSetup.append("")
            forecastsSetup.append([nil])
        }
        days = daysSetup
        forecasts = forecastsSetup
    }
    
    func createEmptyForecastsPerDay(forecastsPerDay: Int) -> [Forecast?] {
        var tempForecasts = [Forecast?]()
        for _ in 0...(forecastsPerDay - 1) { // create empty items in array as NSSet is not ordered
            tempForecasts.append(nil)
        }
        return tempForecasts
    }
}


