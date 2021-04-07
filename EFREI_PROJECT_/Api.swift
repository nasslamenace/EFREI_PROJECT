//
//  Api.swift
//  EFREI_PROJECT_
//
//  Created by Nassim Guettat on 24/03/2021.
//

import Foundation



//------------------------STRUCT-------------------------------------------

struct Airtable {
    static var key = "?api_key=keyrdKgCPBL5DlKi1"
    static var link = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV"
    static var locationLink = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Event%20locations"
    static var scheduleLink = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule"
    static var topicsLink = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Topics%20%26%20themes"
    static var speakersLink = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees"
    static var sponsorsLink = "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors"
    
    static func fetchSchedule(from url: String,comp: @escaping ([Schedule])->()){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Schedules: \(error)")
                return
              }
            
            var result: ScheduleResponse?
            
            do{
                result = try JSONDecoder().decode(ScheduleResponse.self, from: data!)
            }
            catch{
                print("failed to convert")
            }
            
            guard let json = result else{
                return
            }
            
            /*for activity in json.records{
                self.getLocation(from: Airtable.LocationLink + "/" + activity.fields.location![0] + Airtable.key)
            }*/
            comp(json.records.sorted())
            

        
        })
        task.resume()
    }
    
    static func fetchSpeakers(from url: String,comp: @escaping ([Speaker])->()){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Speakers: \(error)")
                return
              }
            
            var result: SpeakerResponse?
            
            do{
                result = try JSONDecoder().decode(SpeakerResponse.self, from: data!)
            }
            catch{
                print("failed to convert")
            }
            
            guard let json = result else{
                return
            }
            
            comp(json.records)
            

        
        })
        task.resume()
    }
    
    static func fetchSponsors(from url: String,comp: @escaping ([Sponsor])->()){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Sponsors: \(error)")
                return
              }
            
            var result: SponsorResponse?
            
            do{
                result = try JSONDecoder().decode(SponsorResponse.self, from: data!)
            }
            catch{
                print("failed to convert")
            }
            
            guard let json = result else{
                return
            }
            
            comp(json.records)
            

        
        })
        task.resume()
    }
    
    static func fetchLocation(from url: String,comp: @escaping ([Location])->()){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Sponsors: \(error)")
                return
              }
            
            var result: LocationResponse?
            
            do{
                result = try JSONDecoder().decode(LocationResponse.self, from: data!)
            }
            catch{
                print("failed to convert")
            }
            
            guard let json = result else{
                return
            }
            
            comp(json.records)
            

        
        })
        task.resume()
    }
    
    static func getLocation(from url: String, comp: @escaping (Location)->()){
        //let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Type: \(error)")
              
                return
              }
            
            var result: Location?
            
            do{
                result = try JSONDecoder().decode(Location.self, from: data!)
            }
            catch{
              
                print("failed to convert + " + url)
            }
            
            guard let json = result else{
                
                return
            }
            
            comp(json)
        })
        task.resume()
    }
    
    static func getTopic(from url: String, comp: @escaping (String)->()){
        //let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Type: \(error)")
              
                return
              }
            
            var result: Topic?
            
            do{
                result = try JSONDecoder().decode(Topic.self, from: data!)
            }
            catch{
              
                print("failed to convert")
            }
            
            guard let json = result?.fields.topic else{
                
                return
            }
            
            comp(json)
        })
        task.resume()
    }
    
    static func getSpeaker(from url: String, comp: @escaping (String)->()){
        //let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Type: \(error)")
              
                return
              }
            
            var result: Speaker?
            
            do{
                result = try JSONDecoder().decode(Speaker.self, from: data!)
            }
            catch{
              
                print("failed to convert" + url)
            }
        
            guard let json = result?.fields.name else{
                
                return
            }
            
            comp(json)
        })
        task.resume()
    }
    
    static func getSponsor(from url: String, comp: @escaping (Sponsor)->()){
        //let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Type: \(error)")
              
                return
              }
            
            var result: Sponsor?
            
            do{
                result = try JSONDecoder().decode(Sponsor.self, from: data!)
            }
            catch{
              
                print("failed to convert" + url)
            }
        
            guard let json = result else{
                
                return
            }
            
            comp(json)
        })
        task.resume()
    }
    
    static func getActivity(from url: String, comp: @escaping (Schedule)->()){
        //let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching Type: \(error)")
              
                return
              }
            
            var result: Schedule?
            
            do{
                result = try JSONDecoder().decode(Schedule.self, from: data!)
            }
            catch{
              
                print("failed to convert" + url)
            }
        
            guard let json = result else{
                
                return
            }
            
            comp(json)
        })
        task.resume()
    }
}

struct ScheduleResponse: Codable{
    let records: [Schedule]
}

struct LocationResponse: Codable{
    let records: [Location]
}

struct TopicResponse: Codable {
    let records: [Topic]
}

struct SpeakerResponse: Codable {
    let records: [Speaker]
}

struct SponsorResponse: Codable {
    let records: [Sponsor]
}


struct Schedule: Codable, Comparable{
    static func < (lhs: Schedule, rhs: Schedule) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let start = dateFormatter.date(from: lhs.fields.start ?? "2017-01-09T11:00:00.000Z")!
        let start2 = dateFormatter.date(from: rhs.fields.start ?? "2017-01-09T11:00:00.000Z")!
        
        return start < start2
    }
    
    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        return (lhs.fields.start == rhs.fields.start && lhs.fields.end == rhs.fields.end )
    }
    
    let id: String
    let fields: Fields
    let createdTime: String
}


struct Location: Codable{
    let id: String
    let fields: LocationFields
    let createdTime: String
}

struct Topic: Codable{
    let id: String
    let fields: TopicFields
    let createdTime: String
}

struct Speaker: Codable{
    let id: String
    let fields: SpeakerFields
    let createdTime: String
}

struct Sponsor: Codable{
    let id: String
    let fields: SponsorFields
    let createdTime: String
}

struct LocationFields: Codable {
    let description: String?
    let name: String?
    let adress: String?
    let image: [Photo]?
    let scheduledEvents: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name = "Space name"
        case adress = "Building location"
        case description = "Description"
        case image = "Photo(s)"
        case scheduledEvents = "Scheduled events"
    }
}
struct Photo: Codable{
    let id: String?
    let url: String?
    let fileName: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case fileName = "filename"
    }
}

struct TopicFields: Codable {
    let topic: String?
    let events: [String]?
    enum CodingKeys: String, CodingKey {
        case topic = "Topic / theme"
        case events = "Relevant event(s)"
    }
}

struct SpeakerFields: Codable {
    let role: String?
    let company: [String]?
    let status: String?
    let email: String?
    let type: String?
    let speakingEvents: [String]?
    let name: String?
    let phone: String?
    enum CodingKeys: String, CodingKey {
        case role = "Role"
        case company = "Company"
        case status = "Status"
        case email = "Email"
        case type = "Type"
        case speakingEvents = "Speaking at"
        case name = "Name"
        case phone = "Phone"
    }
}

struct SponsorFields: Codable {
    let name: String?
    let contacts: [String]?
    let amount: Double?
    let notes: String?
    let status: String?
    enum CodingKeys: String, CodingKey {
        case name = "Company"
        case contacts = "Contact(s)"
        case amount = "Sponsored amount"
        case notes = "Notes"
        case status = "Status"
    }
}

struct Fields: Codable {
    let activity: String?
    let start: String?
    let end: String?
    let notes: String?
    let location: [String]?
    let speakers: [String]?
    let topic: [String]?
    let type: String?
    
    
    enum CodingKeys: String, CodingKey {
        case speakers = "Speaker(s)"
        case topic = "Topic / theme"
        case activity = "Activity"
        case start = "Start"
        case end = "End"
        case notes = "Notes"
        case location = "Location"
        case type = "Type"
    }
    

 
}

extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}


//----------------------------PROTOCOLS-----------------------------

protocol AirTableDelegate {
    func scheduleRetrieved(schedules: [Schedule])
}
