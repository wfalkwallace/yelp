//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var client: YelpClient!
    var results: [Result]!
    var searchBar: UISearchBar!
    
    var consumerKey: String!
    var consumerSecret: String!
    var token: String!
    var tokenSecret: String!
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        consumerKey = defaults.stringForKey("ConsumerKey")
        consumerSecret = defaults.stringForKey("ConsumerSecret")
        token = defaults.stringForKey("Token")
        tokenSecret = defaults.stringForKey("TokenSecret")
        
        loadResults()
        
        resultsTableView.estimatedRowHeight = 150
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func loadResults() {
        client = YelpClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: token, accessSecret: tokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            for result in ((response as NSDictionary)["businesses"] as NSArray) {
                let resultName = result["name"] as String
                let resultImageURL = result["image_url"]! as String
                let resultDistance = result["distance"] as Float
                let resultFormattedDistance = NSString(format: "%.2f", resultDistance / 1609.34)
                let resultRatingURL = result["rating_img_url"]! as String
                let resultReviewerCount = result["review_count"]! as Int
                let resultPrice = "$?"
                let resultAddress = ((result["location"] as NSDictionary)["address"] as NSArray)[0] as String
                let resultCategoriesRaw = result["categories"]! as [[String]]
                let resultCategories = ",".join(resultCategoriesRaw.map({
                    $0[0] as String
                }))
                
                self.results.append(Result(resultName: resultName, resultImageURL: resultImageURL, resultDistance: resultDistance, resultRatingURL: resultRatingURL, resultReviewerCount: resultReviewerCount, resultAddress: resultAddress, resultCategories: resultCategories))
            }
            self.resultsTableView.reloadData()
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        })

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = results {
            return results.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.ResultCell") as ResultTableViewCell
        cell.result = self.results[indexPath.row]
        cell.resultNumber = indexPath.row + 1
        return cell
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

