//
//  NetworkRequest.swift
//  WeatherTests
//
//  Created by Cerebro on 19/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import XCTest
@testable import Weather
import Alamofire

class NetworkRequestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSitesRequestSuccess() {
        let request = NetworkRequest()
        let expect = expectation(description: "Alamofire")
        request.locationsRequest { (result) in
            XCTAssertTrue(result.isSuccess)
            expect.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil) //failures can be network connection related
    }
    
    func testLocationRequestSuccess() {
        let request = NetworkRequest()
        let expect = expectation(description: "Alamofire")
        request.locationDetailRequest(locationId: "3840") { (result) in
            XCTAssertTrue(result.isSuccess)
            expect.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil) //failures can be network connection related
    }
    
}
