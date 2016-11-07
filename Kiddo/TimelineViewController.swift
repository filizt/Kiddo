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

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "eventCell", bundle: Bundle.main)

        self.timelineTableView.register(nib, forCellReuseIdentifier: EventTableViewNib.identifier())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
