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

    var events = [Event]() {
        didSet {
            self.timelineTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timelineTableView.dataSource = self
        self.timelineTableView.delegate = self

        let nib = UINib(nibName: "eventCell", bundle: Bundle.main)
        self.timelineTableView.register(nib, forCellReuseIdentifier: EventTableViewNib.identifier())
        
        self.timelineTableView.estimatedRowHeight = 100
        self.timelineTableView.rowHeight = UITableViewAutomaticDimension
        
        //This needed to be added to the main queue because fetchEvents was running asynchronously and was getting the data after viewDidLoad was done.
        EventfulAPI.shared.fetchEvents { (events) in
            OperationQueue.main.addOperation {
                self.events = events!
            }
            
        }

    }
}

extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.timelineTableView.dequeueReusableCell(withIdentifier: EventTableViewNib.identifier(), for: indexPath) as! EventTableViewNib
        
        let currentEvent = self.events[indexPath.row]
        cell.event = currentEvent
        
        return cell
    }
}
