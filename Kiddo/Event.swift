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
    let eventAddress: String?
    let eventDate: String?
    let eventVenueName: String?
    let eventStartTime: String?
//    let eventPrice: String?
    let eventImageUrl: String?
//    let eventImageDictionary: [
//    String: Any]
    
    //let eventAddress: String?
    let eventDescription: String?


    init?(jsonDictionary: [String: Any]) {
        
        if let eventTitle = jsonDictionary["title"] as? String {

            if let alldayFlagSet = jsonDictionary["all_day"] as? String, alldayFlagSet == "2" {
                return nil
            }

            print(jsonDictionary)

            let eventVenueName = jsonDictionary["venue_name"] as? String
            let eventDate = jsonDictionary["start_time"] as? String
            let eventDescription = jsonDictionary["description"] as? String
            let eventAddress = jsonDictionary["venue_address"] as? String
            

            var newDateString:String? = nil
            if eventDate?.isEmpty != true {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(identifier: "GMT")
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                if let date = dateFormatter.date(from: eventDate!) {
                    dateFormatter.dateFormat = "HH:mm"
                    dateFormatter.timeStyle = .short
                    newDateString = dateFormatter.string(from: date)

                }
            }

            eventStartTime = newDateString




        // if let constants only scope down into the if statement
            
//        if let eventPrice = jsonDictionary["price"] as? String {
//            if eventPrice == "" {
//                self.eventPrice = "Free"
//            } else {
//                self.eventPrice = eventPrice
//            }
//        } else {
//            self.eventPrice = "Free"
//        }
//            
        
        if let eventImageUrls = jsonDictionary["image"] as? [String:Any] {
            let key:String = eventImageUrls.keys.first!
            let eventImageUrlObject: [String: Any]

            switch key {
            case "large":
                eventImageUrlObject = eventImageUrls["large"] as! [String: Any]
                let eventImageUrl = eventImageUrlObject["url"] as? String
                self.eventImageUrl = eventImageUrl
            case "medium":
                eventImageUrlObject = eventImageUrls["medium"] as! [String: Any]
                let eventImageUrl = eventImageUrlObject["url"] as? String
                self.eventImageUrl = eventImageUrl
            default:
                self.eventImageUrl = nil
                print("Default case hit while extracting image URL from JSON")
            }
        } else {
            self.eventImageUrl = nil
        }

        self.eventTitle = eventTitle
        self.eventVenueName = eventVenueName
        self.eventDate = eventDate
        self.eventDescription = eventDescription
        self.eventAddress = eventAddress
//        self.eventImageUrl = eventImageUrl
                    
    } else {
    
    return nil
            
    }
    
 }

    func dateFormatter(dateString: String) -> String? {
        if dateString.isEmpty != true {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:dd"

            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "HH:mm:dd"
                let newDateString = dateFormatter.string(from: date)
                print(newDateString)
                return newDateString
            }
        }

        return nil

    }

}
