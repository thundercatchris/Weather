//
//  NetworkRequest.swift
//  Major Roads
//
//  Created by Cerebro on 11/05/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequest {
    
    let apiKey = "13b23e8c-d7ad-4dad-8f39-4fa0a437d1ff"
    let apiBaseURL = "http://datapoint.metoffice.gov.uk/public/data/"
    
    func locationsRequest(completionHandler: @escaping (_ result: Result<String>) -> Void) {
        let url = "\(apiBaseURL)val/wxobs/all/datatype/sitelist?key=\(apiKey)"
        Alamofire.request(url).responseString { response in
            completionHandler(response.result)
        }
    }
    
    func locationDetailRequest(locationId: String, completionHandler: @escaping (_ result: Result<String>) -> Void) {
        let url = "\(apiBaseURL)val/wxfcs/all/xml/\(locationId)?res=3hourly&key=\(apiKey)"
        Alamofire.request(url).responseString { response in
            completionHandler(response.result)
        }
    }
    
}
