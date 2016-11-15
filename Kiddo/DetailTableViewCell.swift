//
//  DetailTableViewCell.swift
//  Kiddo
//
//  Created by Filiz Kurban on 11/10/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var moreInfoButtonPressed: UIButton!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventImage: UIImageView!

    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func moreInfoButtonPressed(_ sender: AnyObject) {
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
