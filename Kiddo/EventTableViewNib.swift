//
//  EventTableViewNib.swift
//  Kiddo
//
//  Created by Rachael A Helsel on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class EventTableViewNib: UITableViewCell {
    

    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var eventVenueName: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    
    @IBOutlet weak var eventPrice: UILabel!
    
    @IBOutlet weak var eventStartTime: UILabel!
    
    //Everytime this class is instantiated
    var event: Event! {
        didSet {
            
            self.eventTitle.text = event.eventTitle
//            self.eventImage.text = event.eventImage
            self.eventVenueName.text = event.eventVenueName
            self.eventDate.text = event.eventDate
            self.eventPrice.text = event.eventPrice
//            self.eventStartTime.text = event.eventStartTime
            
            
        }
        
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
