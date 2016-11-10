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
    
    @IBOutlet weak var eventAddress: UILabel!
    
    @IBOutlet weak var eventStartTime: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\(event.eventDescription)<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
        
//        self.eventDescription.text = event.eventDescription
        let eventD = event.eventDescription
        let replacedPTag = eventD?.replacingOccurrences(of: "<p>", with: "", options: .literal, range: nil)
        let replacedClosedPTag = replacedPTag?.replacingOccurrences(of: "</p>", with: "", options: .literal, range: nil)

        let replacedBRTag = replacedClosedPTag?.replacingOccurrences(of: "<br>", with: "", options: .literal, range: nil)
        
        let replacedClosedBRTag = replacedBRTag?.replacingOccurrences(of: "</br>", with: "", options: .literal, range: nil)


        print("OUR STRINGS")
        print("\(eventD)")
        print("\(replacedClosedBRTag)")
        
        self.eventDescription.text = replacedClosedBRTag
        
//        stringByReplacingOccurrencesOfString("(?i)<p\\b[^<]*>\\s*</p>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        self.eventAddress.text = event.eventAddress
        self.eventStartTime.text = event.eventStartTime

        self.eventImage.image = self.image
        self.eventImage.contentMode = .scaleAspectFill

    }



}
