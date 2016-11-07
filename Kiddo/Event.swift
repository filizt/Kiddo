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
    let eventDate: String
    let eventVenueName: String?
    let eventStartTime: String?
    //let eventPrice: String?
    let eventImageUrl: String?
    //let eventAddress: String?
    //let eventDescription: String?


    init?(jsonDictionary: [String: Any]) {
        if let eventTitle = jsonDictionary["title"] as? String,
            let eventVenueName = jsonDictionary["venue_name"] as? String,
            let eventDate = jsonDictionary["start_time"] as? String {
        //need to parse eventDate to get date and not the start time.

        let eventStartTime = jsonDictionary["start_time"] as? String
        let eventImageUrl = jsonDictionary["images"] as? String
        
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
