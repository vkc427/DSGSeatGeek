//
//  EventObject.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/14/21.
//

import Foundation

struct Events: Codable {
    var event: [EventINfo]?
    
    enum CodingKeys: String, CodingKey {
        case event = "events"
      }
}

struct EventINfo: Codable {
    var name: String?
    var venue: Venue?
    var eventDate: String?
    var id: Int?
    var performers: [Performer]?
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case id = "id"
        case venue = "venue"
        case eventDate = "datetime_local"
        case performers = "performers"
      }
}

struct Performer: Codable {
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
      }
}

struct Venue: Codable {
    var location: String?
    
    enum CodingKeys: String, CodingKey {
        case location = "display_location"
      }
}
