//
//  EventfulAPI.swift
//  Kiddo
//
//  Created by Filiz Kurban on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

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
        self.urlComponents.queryItems?.append(URLQueryItem(name:"c", value: "family_fun_kids"))
        self.urlComponents.queryItems?.append(URLQueryItem(name:"location", value: "seattle"))
        self.urlComponents.queryItems?.append(URLQueryItem(name:"image_sizes", value: "large"))

        print(urlComponents.url)


        guard let url = urlComponents.url else { completion(nil);  return }

        self.session.dataTask(with: url, completionHandler: {(data, response, error) in
            if error != nil { completion(nil); return }

            guard let data = data else { completion(nil); return }

            print("printing data")
            print(data)

            do {

                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any], let events = json["events"] as? [[String: Any]] {
                    var events = [Event]()

                }

            } catch {
                //handle error here
            }


        }).resume()





    }

    func fetchEventPhoto(event: Event, completion: @escaping FetchEventPhotoCompletion) {

    }

    func configureURL() {
        self.urlComponents.scheme = "https"
        self.urlComponents.host = "api.eventful.com"
        self.urlComponents.queryItems = [URLQueryItem(name:"app_key", value: APP_KEY)]
    }
}


