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
    
    @IBOutlet weak var eventLocation: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    
    @IBOutlet weak var eventPrice: UILabel!
    
    @IBOutlet weak var eventTime: UILabel!
    

    var event: Event! {
        didSet {
            
            self.eventTitle.text = event.eventTitle
//            self.eventImage.text = event.eventImage
            self.eventLocation.text = event.eventLocation
            self.eventDate.text = event.eventDate
            self.eventPrice.text = event.eventPrice
            self.eventTime.text = event.eventTime
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
