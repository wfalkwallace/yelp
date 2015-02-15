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
    var searchBar: UISearchBar = UISearchBar()
    
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
        navigationItem.titleView = searchBar
        resultsTableView.estimatedRowHeight = 150
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        
        loadResults(nil, categories: nil)
    }
    
    func loadResults(term: String?, categories: String?) {
        
        client.search(["term": term, "categories": categories], success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        
            for result in ((response as NSDictionary)["businesses"] as NSArray) {
                let resultName = result["name"] as String
                let resultImageURL = result["image_url"]! as String
                let resultDistance = result["distance"] as Float
                let resultRatingURL = result["rating_img_url"]! as String
                let resultReviewerCount = result["review_count"]! as Int
                let resultAddress = ((result["location"] as NSDictionary)["address"] as NSArray)[0] as String
                let resultCategories = ",".join((result["categories"]! as [[String]]).map({
                    $0[0] as String
                }))
                
                self.results.append(Result(resultName: resultName,
                                           resultImageURL: resultImageURL,
                                           resultDistance: resultDistance,
                                           resultRatingURL: resultRatingURL,
                                           resultReviewerCount: resultReviewerCount,
                                           resultAddress: resultAddress,
                                           resultCategories: resultCategories))
            }
            
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
        loadResults(searchBar.text, categories: nil)
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, filterValues: [String]) {
        loadResults(nil, categories: ",".join(filterValues))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

