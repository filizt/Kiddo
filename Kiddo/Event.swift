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
    var eventDate: String?
    let eventVenueName: String?
    let eventStartTime: String?
//    let eventPrice: String?
    let eventImageUrl: String?
    let allDayFlag: Bool
    
    //let eventAddress: String?
    let eventDescription: String?


    init?(jsonDictionary: [String: Any]) {
        
        if let eventTitle = jsonDictionary["title"] as? String {

            if let alldayFlag = jsonDictionary["all_day"] as? String, (alldayFlag == "2" || alldayFlag == "1") {
                self.allDayFlag = true
            } else {
                self.allDayFlag = false
            }


            let eventVenueName = jsonDictionary["venue_name"] as? String
            let eventDate = jsonDictionary["start_time"] as? String
            let eventDescription = jsonDictionary["description"] as? String
            let eventAddress = jsonDictionary["venue_address"] as? String
            

            var newTimeString:String? = nil
            var newDateString:String? = nil
            if eventDate?.isEmpty != true {
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(identifier: "GMT")
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                if let date = dateFormatter.date(from: eventDate!) {
                    dateFormatter.dateFormat = "HH:mm"
                    dateFormatter.timeStyle = .short
                    newTimeString = dateFormatter.string(from: date)

                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeStyle = .long
                    newDateString = dateFormatter.string(from: date)

                }
            }
            self.eventDate = newDateString
            self.eventStartTime = newTimeString




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
