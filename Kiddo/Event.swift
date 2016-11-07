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
    let eventLocation: String
    let eventDate: String
    let eventTime: String
    let eventPrice: String
    let eventImage: String

    init?(jsonDictionary: [String: Any]) {
        if let eventTitle = jsonDictionary["title"] as? String,
        let eventLocation = jsonDictionary["pretty_name"] as? String,
        let eventDate = jsonDictionary["mf_start_time"] as? String,
        let eventTime = jsonDictionary["tf_start_time"] as? String,
        let eventPrice = jsonDictionary["price"] as? String,
            let eventImage = jsonDictionary["_list_images"] as? String {
        
        self.eventTitle = eventTitle
        self.eventLocation = eventLocation
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventPrice = eventPrice
        self.eventImage = eventImage
            
        } else {
        
            return nil
        }
    
    }

}
