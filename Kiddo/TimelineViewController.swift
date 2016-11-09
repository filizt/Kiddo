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
            print(">>>>>>>>>>>>>>>\(events[0].eventStartTime)<<<<<<<<<<<<<<<<<<<<<")
        }
    }
    

    var defaultImagesList = [UIImage]()

    //image cache
    var imageCache = [String: UIImage]() {
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
            self.events = events!

            var counter = 1
            for eachEvent in self.events {
                print("****Event #: ", counter)
                counter += 1
                print("****Event img url:", eachEvent.eventImageUrl)
            }

            for eachEvent in self.events {
                 EventfulAPI.shared.fetchEventPhoto(event: eachEvent, completion: { (image) in
                    if image != nil {
                        self.imageCache[eachEvent.eventImageUrl!] = image
                    } else {
                        //assing a placeholder image
                    }
                 })
            }
        }
        self.loadDefaultImages()
    }

    func loadDefaultImages() {
        self.defaultImagesList.append(UIImage(named: "kiddo_default_2")!)
        self.defaultImagesList.append(UIImage(named: "kiddo_default_1")!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetailView" {
            let selectedIndex = timelineTableView.indexPathForSelectedRow!.row
            let selectedEvent = self.events[selectedIndex]
            let currentCell = timelineTableView.cellForRow(at: timelineTableView.indexPathForSelectedRow!)! as! EventTableViewNib
            
            //if this seque is going to the DetailViewController then select a tweet
            if let destinationViewController = segue.destination as? DetailViewController {
                destinationViewController.event = selectedEvent
                destinationViewController.image = currentCell.eventImage?.image

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
        if currentEvent.eventImageUrl != nil {
            if let image = imageCache[currentEvent.eventImageUrl!] {
                let img = image.cropImageForTimelineView()
                cell.eventImage.image = img.imageWithGradient()
            }
        } else {

                if indexPath.row == 0 {
                    let img = defaultImagesList[0].cropImageForTimelineViewWithRespectToInitialSize()
                    cell.eventImage.image = img.imageWithGradient()
                } else {
                    let img = defaultImagesList[Int(indexPath.row % defaultImagesList.count)].cropImageForTimelineViewWithRespectToInitialSize()
                    cell.eventImage.image = img.imageWithGradient()
                }

        }

        //cell.eventImage.contentMode = UIViewContentMode.scaleAspectFill



        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailView", sender: nil)
        
        

    }
}
