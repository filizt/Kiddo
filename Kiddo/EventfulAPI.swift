//
//  EventfulAPI.swift
//  Kiddo
//
//  Created by Filiz Kurban on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

let APP_KEY = "Sx7TVrRw7SCWzNch"
typealias FetchEventsCompletion = ([Event]?) -> ()
typealias FetchEventPhotoCompletion = (UIImage?) -> ()

//http://api.eventful.com/json/events/search?app_key=Sx7TVrRw7SCWzNch&c=family_fun_kids&location=seattle&image_sizes=large

class EventfulAPI {

    static let shared = EventfulAPI()

    private var session: URLSession
    private var urlComponents: URLComponents

    private init() {
        self.session = URLSession(configuration: .ephemeral)
        self.urlComponents = URLComponents()
        self.configureURL()

    }

    func fetchEvents(completion: @escaping FetchEventsCompletion) {
        self.urlComponents.path = "/json/events/search"
        self.urlComponents.queryItems?.append(URLQueryItem(name:"category", value: "family_fun_kids"))
        self.urlComponents.queryItems?.append(URLQueryItem(name:"location", value: "seattle"))
        self.urlComponents.queryItems?.append(URLQueryItem(name:"image_sizes", value: "large"))
        self.urlComponents.queryItems?.append(URLQueryItem(name:"date", value: "Today"))
        //self.urlComponents.queryItems?.append(URLQueryItem(name:"sort_order", value: "popularity"))
        self.urlComponents.queryItems?.append(URLQueryItem(name:"sort_direction", value: "ascending"))
        self.urlComponents.queryItems?.append(URLQueryItem(name:"page_size", value: "50"))
        //popularity

        

        func returnToMainWith (result: [Event]?) {
            OperationQueue.main.addOperation { completion(result) }
        }
        print(urlComponents.url!)
        guard let url = urlComponents.url else { completion(nil);  return }

        self.session.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil { completion(nil); return }

            guard let data = data else { returnToMainWith(result: nil); return }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    var eventsList = [Event]()
                    if let events = json["events"] as? [String: Any] {
                        if let eventsArray = events["event"] as? [[String:Any]] {
                            for eachEvent in eventsArray {
                                let event = Event(jsonDictionary: eachEvent)
                                if event != nil {
                                    eventsList.append(event!)}
                            }
                            returnToMainWith(result: eventsList)
                        }
                    }
                }
            } catch {
                print("Error JSONSerialization.jsonObject: " + error.localizedDescription)
                returnToMainWith(result: nil)
            }
        }).resume()
    }

    func fetchEventPhoto(event: Event, completion: @escaping FetchEventPhotoCompletion) {

        func returnToMainWith (result: UIImage?) {
            OperationQueue.main.addOperation { completion(result) }
        }

        OperationQueue().addOperation {
            if event.eventImageUrl != nil {
                let urlString = "https:" + event.eventImageUrl!
                guard let url = URL(string: urlString) else { returnToMainWith(result: nil); return }

                do {
                    let data = try Data(contentsOf: url)
                    guard let image = UIImage(data: data) else { returnToMainWith(result: nil); return }
                    returnToMainWith(result: image)
                } catch {
                    print("Error initializing data through URL")
                    returnToMainWith(result: nil)
                }
            } else {
                returnToMainWith(result: nil)
            }
        }
    }

    func configureURL() {
        self.urlComponents.scheme = "https"
        self.urlComponents.host = "api.eventful.com"
        self.urlComponents.queryItems = [URLQueryItem(name:"app_key", value: APP_KEY)]
    }
}


