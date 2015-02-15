//
//  FiltersViewController.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate: class {
    func filtersViewController(filtersViewController: FiltersViewController,
                               filterValues: [String])
}

class FiltersViewController: UIViewController,
                             UITableViewDataSource,
                             UITableViewDelegate {

    @IBOutlet weak var filtersTableView: UITableView!
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onApplyButton(sender: AnyObject) {
        delegate?.filtersViewController(self, filterValues: ["thai"])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.FilterCell") as FilterTableViewCell
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
