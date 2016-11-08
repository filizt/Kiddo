//
//  DetailViewController.swift
//  Kiddo
//
//  Created by Filiz Kurban on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var event: Event!
    
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var eventVenueName: UILabel!
    
    @IBOutlet weak var eventStartTime: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\(event.eventDescription)<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
//        Set these to the outlets soon
        self.eventDescription.text = event.eventDescription
        self.eventVenueName.text = event.eventVenueName
        self.eventStartTime.text = event.eventStartTime

    }



}
