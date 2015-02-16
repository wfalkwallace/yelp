//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                      UITableViewDataSource,
                      UITableViewDelegate,
                      UISearchBarDelegate,
                      FiltersViewControllerDelegate {
    
    var client: YelpClient!
    var results: [Result] = []
    var filteredResults: [Result] = []

    var categoryFilters: [String] = []
    var dealFilter: Bool = false
    var radiusFilter: (String, Float?) = ("Best Match", nil)
    var sortFilter = 0
    
    var searchBar: UISearchBar = UISearchBar()
    var filterController: FiltersViewController?
    @IBOutlet weak var resultsTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        let consumerKey = defaults.stringForKey("ConsumerKey")
        let consumerSecret = defaults.stringForKey("ConsumerSecret")
        let token = defaults.stringForKey("Token")
        let tokenSecret = defaults.stringForKey("TokenSecret")
        
        client = YelpClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: token, accessSecret: tokenSecret)

        searchBar.delegate = self
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        
        
        resultsTableView.estimatedRowHeight = 150
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        
        loadResults(nil)
    }
    
    func loadResults(term: String?) {
        client.search(term, categories: categoryFilters, deals: dealFilter, sort: sortFilter, radius: radiusFilter.1, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.results = Result.resultArrayFromDictionary((response as NSDictionary)["businesses"] as NSArray)
            self.filteredResults = self.results
            self.resultsTableView.reloadData()
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        })

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.ResultCell") as ResultTableViewCell
        cell.resultNumber = indexPath.row + 1
        cell.result = self.filteredResults[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange search: String) {
        filteredResults = search.isEmpty ? results : results.filter({(data: Result) -> Bool in
            return data.resultName.rangeOfString(search, options: .CaseInsensitiveSearch) != nil
        })
        
        resultsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        loadResults(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        loadResults(nil)
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, categories: [String], deals: Bool, radius: (String, Float?), sort: Int) {
        categoryFilters = categories
        dealFilter = deals
        sortFilter = sort
        radiusFilter = radius
        loadResults(searchBar.text)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if let filterController = segue!.destinationViewController.topViewController as? FiltersViewController {
            filterController.delegate = self
            filterController.categoryFilters = categoryFilters
            filterController.dealFilter = dealFilter
            filterController.radiusFilter = radiusFilter
            filterController.sortFilter = sortFilter
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

