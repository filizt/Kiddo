//
//  Event.swift
//  Kiddo
//
//  Created by Rachael A Helsel on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import Foundation

class Event {

    let eventTitle: String
    let eventDate: String?
    let eventVenueName: String?
    let eventStartTime: String?
    let eventPrice: String?
    let eventImageUrl: String?
    //let eventAddress: String?
    //let eventDescription: String?


    init?(jsonDictionary: [String: Any]) {
        
        print(jsonDictionary)
        
        if let eventTitle = jsonDictionary["title"] as? String {
            let eventVenueName = jsonDictionary["venue_name"] as? String
            let eventDate = jsonDictionary["start_time"] as? String
            let eventStartTime = jsonDictionary["start_time"] as? String
        
        // if let constants only scope down into the if statement
        if let eventPrice = jsonDictionary["price"] as? String {
            if eventPrice == "" {
                self.eventPrice = "Free"
            } else {
                self.eventPrice = eventPrice
            }
        } else {
            self.eventPrice = "Free"
        }
        
        let eventImageUrl = jsonDictionary["image"] as? String
        
        self.eventTitle = eventTitle
        self.eventVenueName = eventVenueName
        self.eventDate = eventDate
        self.eventStartTime = eventStartTime
        self.eventImageUrl = eventImageUrl
        
    } else {
    
    return nil
            
    }
    
 }

}
