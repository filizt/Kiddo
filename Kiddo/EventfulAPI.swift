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

    var urlComponents:URLComponents

    private init() {
        self.urlComponents = URLComponents()
        self.configureURL()
    }

    func fetchEvents(completion: FetchEventsCompletion) {
        self.urlComponents.path = "/json/events/search?"
        self.urlComponents.queryItems = [URLQueryItem(name:"c", value: "family_fun_kids")]
        self.urlComponents.queryItems = [URLQueryItem(name:"location", value: "seattle")]
        self.urlComponents.queryItems = [URLQueryItem(name:"image_sizes", value: "large")]

        print(urlComponents.url)

        var events = [Event]()

        completion(events)

    }

    func fetchEventPhoto(event: Event, completion: @escaping FetchEventPhotoCompletion) {

    }

    func configureURL() {
        self.urlComponents.scheme = "https"
        self.urlComponents.host = "api.eventful.com"
        self.urlComponents.queryItems = [URLQueryItem(name:"app_key", value: APP_KEY)]
    }
}

