//
//  DetailViewController.swift
//  Kiddo
//
//  Created by Filiz Kurban on 11/7/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var event: Event!
    var image: UIImage!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none

        let nib = UINib(nibName: "detailCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: DetailTableViewCell.identifier())
        self.title = event.eventTitle
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier(), for: indexPath) as! DetailTableViewCell

        cell.eventImage.image = self.image
        cell.eventImage.contentMode = .scaleAspectFill

        if event.eventDescription != nil {
            let text = event.eventDescription?.html2AttributedString?.string
            print("***", text)
            cell.eventDescription.text = text
        } else {
            cell.eventDescription.text = "Please find more information about this event in below link."
        }

        cell.eventLocation.text = event.eventVenueName
        cell.eventDate.text = event.eventDate


        return cell
    }



    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if event.eventUrl != nil {
            presentSafariViewController(url: event.eventUrl!)
        }
    }

    func presentSafariViewController(url: String) {
        let safariVC = SFSafariViewController(url:URL(string: url)!)
        self.present(safariVC, animated: true, completion: nil)
    }




}
