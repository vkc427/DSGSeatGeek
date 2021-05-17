//
//  EventUtilities.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/14/21.
//

import Foundation

struct EventURLs {
    static let kAPI_EventAPI = "https://api.seatgeek.com/2/events?client_id="
    static let kAPI_SATResults = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
}

struct Messages {
    static let ErrorMessage = "Application unable to complete your request. Please try again later."
    static let NoData = "No Information for the Selected Event"
    static let Empty = "-"
    static let EmptyString = ""
}

struct Auth {
    static let ClientID = "MjE5MjIyOTB8MTYyMTAwNzc0NS43NDI1NDUx"
}
