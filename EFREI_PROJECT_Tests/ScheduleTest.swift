//
//  ScheduleTest.swift
//  EFREI_PROJECT_Tests
//
//  Created by Nassim Guettat on 07/04/2021.
//

import XCTest
@testable import EFREI_PROJECT_

class ScheduleTest: XCTestCase {
    
    
    
    func testInitSchedule(){
        
        let fields = Fields.init(activity: "myActivity", start: "2016-10-30T21:47:21.000Z", end: "2016-11-30T21:47:21.000Z", notes: "my notes", location: ["111"], speakers: ["222"], topic: ["444"], type: "event")
        
        let schedule = Schedule.init(id: "myId", fields: fields, createdTime: "2016-10-30T21:47:21.000Z")

        XCTAssertEqual(schedule.id, "myId")
    }
    
    func testOperators(){
        
        let fields = Fields.init(activity: "myActivity", start: "2016-10-30T21:47:21.000Z", end: "2016-11-30T21:47:21.000Z", notes: "my notes", location: ["111"], speakers: ["222"], topic: ["444"], type: "event")
        
        let schedule = Schedule.init(id: "myId", fields: fields, createdTime: "2016-10-30T21:47:21.000Z")
        
        let fields2 = Fields.init(activity: "myActivity", start: "2016-12-30T21:47:21.000Z", end: "2016-12-30T21:47:21.000Z", notes: "my notes", location: ["111"], speakers: ["222"], topic: ["444"], type: "event")
        
        let schedule2 = Schedule.init(id: "myId", fields: fields2, createdTime: "2016-10-30T21:47:21.000Z")
        
        XCTAssertEqual(schedule < schedule2, true)
        XCTAssertEqual(schedule == schedule2, false)
        
        
        
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
