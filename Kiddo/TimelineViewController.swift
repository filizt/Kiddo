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
    @IBOutlet weak var switchControl: UISegmentedControl!

    var events = [Event]() {
        didSet {
            self.timelineTableView.reloadData()
        }
    }

    var eventsTomorrow = [Event]()
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

        self.setUpNavigationBar()


        //This needed to be added to the main queue because fetchEvents was running asynchronously and was getting the data after viewDidLoad was done.
        EventfulAPI.shared.fetchEventsForToday { (events) in
            self.events = events!
            for eachEvent in self.events {
             EventfulAPI.shared.fetchEventPhoto(event: eachEvent, completion: { (image) in
                if image != nil {
                    self.imageCache[eachEvent.eventImageUrl!] = image
                }
             })
            }
             self.loadDefaultImages()
        }

        EventfulAPI.shared.fetchEventsForTomorrow { (eventsTomorrow) in
            self.eventsTomorrow = eventsTomorrow!
            for eachEvent in self.eventsTomorrow {
                EventfulAPI.shared.fetchEventPhoto(event: eachEvent, completion: { (image) in
                    if image != nil {
                        self.imageCache[eachEvent.eventImageUrl!] = image
                    }
                })
            }
        }
    }

    private func setUpNavigationBar() {
        let newColor = UIColor(red: 255, green: 147, blue: 92)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = newColor
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        //navigationController?.editButtonItem = backItem
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }

    func loadDefaultImages() {
        self.defaultImagesList.append(UIImage(named: "kiddo_default_2")!)
        self.defaultImagesList.append(UIImage(named: "kiddo_default_1")!)
    }

    
    @IBAction func switchButtonPressed(_ sender: UISegmentedControl) {

        self.timelineTableView.reloadData()

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
        if switchControl.selectedSegmentIndex == 0 {
            return events.count
        } else {
            return eventsTomorrow.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var tempArray = [Event]()

        //0 means today, 1 means tomorrow
        if switchControl.selectedSegmentIndex == 0 {
            tempArray = events
        } else {
            tempArray = eventsTomorrow
        }


        let cell = self.timelineTableView.dequeueReusableCell(withIdentifier: EventTableViewNib.identifier(), for: indexPath) as! EventTableViewNib
        
        let currentEvent = tempArray[indexPath.row]
        cell.event = currentEvent
        if currentEvent.eventImageUrl != nil {
            if let image = imageCache[currentEvent.eventImageUrl!] {
                cell.eventImage.image = image.cropImageForTimelineView()
            }
        } else {
            if indexPath.row == 0 {
                cell.eventImage.image = defaultImagesList[0]
            } else {
                cell.eventImage.image = defaultImagesList[Int(indexPath.row % defaultImagesList.count)]
            }
        }

        //timelineTableView.tableFooterView = UIView()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetailView", sender: nil)
        
        

    }
}
