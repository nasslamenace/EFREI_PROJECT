//
//  CustomPin.swift
//  EFREI_PROJECT_Tests
//
//  Created by Nassim Guettat on 07/04/2021.
//

import XCTest
import CoreLocation
@testable import EFREI_PROJECT_

class CustomPinTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testInitCustomPin(){
        
        let fields = LocationFields.init(description: "description", name: "name", adress: "4 rue de Rome", image: [], scheduledEvents: [""])
        
        let location = Location.init(id: "myId", fields: fields, createdTime: "2019-11-15T14:30:00.000Z")
        
        let myPin = CustomPin(pinLocation: location, pinTitle: location.fields.name ?? "Grand ballroom", pinCoordinate: CLLocationCoordinate2D(latitude: 22, longitude: 23), pinSubtitle: location.fields.adress ?? "4 rue de Rome", pinId: location.id)
        
        XCTAssertEqual(myPin.location?.fields.adress, location.fields.adress)
        XCTAssertEqual(myPin.id, "myId")
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
