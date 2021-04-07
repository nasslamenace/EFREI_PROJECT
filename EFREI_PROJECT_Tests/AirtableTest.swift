//
//  AirtableTest.swift
//  EFREI_PROJECT_Tests
//
//  Created by Nassim Guettat on 07/04/2021.
//

import XCTest
@testable import EFREI_PROJECT_

class AirtableTest: XCTestCase {
    
    
    
    func testGetSchedule(){
        
        Airtable.getActivity(from: Airtable.scheduleLink + "/" + "rec38jO5T05cqdJDx" + Airtable.key){ data in
            
            XCTAssertEqual(data.fields.start, "2019-11-15T14:30:00.000Z")
        }
        
    }
    
    func testGetLocation(){
        
        Airtable.getLocation(from: Airtable.locationLink + "/" + "rec2AeKjMRbEQ43hi" + Airtable.key){ data in
            XCTAssertEqual(data.fields.name, "Sapphire room")
        }
        
    }
    
    func testGetTopic(){
        
        Airtable.getTopic(from: Airtable.topicsLink + "/" + "rec2hhpQxN998u8AD" + Airtable.key){ data in
            
            XCTAssertEqual(data, "Welcome to HomeTech 2019!")
        }
        
    }
    
    func testGetSpeaker(){
        
        Airtable.getSpeaker(from: Airtable.speakersLink + "/" + "rec0gsS8qKoCMZi54" + Airtable.key){ data in
            
            XCTAssertEqual(data, "Russell Karkarov")
            
        }
        
    }
    

    func testGetSponsor(){
        
        Airtable.getSponsor(from: Airtable.sponsorsLink + "/" + "rec0T9nvvGLzTfEyM" + Airtable.key){ data in
            
            XCTAssertEqual(data.fields.name, "Absolute Electric")
        }
        
    }
    
    func testFetching(){
        
        Airtable.fetchSchedule(from: Airtable.scheduleLink) {data in
            XCTAssertEqual(data.count > 0, true)
        }
        Airtable.fetchSpeakers(from: Airtable.speakersLink) {data in
            XCTAssertEqual(data.count > 0, true)
        }
        Airtable.fetchSponsors(from: Airtable.sponsorsLink) {data in
            XCTAssertEqual(data.count > 0, true)
        }
        Airtable.fetchLocation(from: Airtable.locationLink) {data in
            XCTAssertEqual(data.count > 0, true)
        }
        
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
