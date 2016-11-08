//
//  TimeLineViewController.swift
//  Kiddo
//
//  Created by Rachael A Helsel on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {


    @IBOutlet weak var timelineTableView: UITableView!

    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "eventCell", bundle: Bundle.main)
        self.timelineTableView.register(nib, forCellReuseIdentifier: EventTableViewNib.identifier())
        
        self.timelineTableView.estimatedRowHeight = 100
        self.timelineTableView.rowHeight = UITableViewAutomaticDimension

        EventfulAPI.shared.fetchEvents { (events) in
            self.events = events!
        }

    }



}
