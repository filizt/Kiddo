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
    var image: UIImage!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var eventVenueName: UILabel!
    
    @IBOutlet weak var eventStartTime: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\(event.eventDescription)<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
        
        self.eventDescription.text = event.eventDescription
        self.eventVenueName.text = event.eventVenueName
        self.eventStartTime.text = event.eventStartTime

        self.eventImage.image = self.image
        self.eventImage.contentMode = .scaleAspectFill

    }



}
