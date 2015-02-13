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
    var results: NSDictionary?
    
    var consumerKey: String?
    var consumerSecret: String?
    var token: String?
    var tokenSecret: String?
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        consumerKey = defaults.stringForKey("ConsumerKey")
        consumerSecret = defaults.stringForKey("ConsumerSecret")
        token = defaults.stringForKey("Token")
        tokenSecret = defaults.stringForKey("TokenSecret")
        
        client = YelpClient(consumerKey: consumerKey!, consumerSecret: consumerSecret!, accessToken: token!, accessSecret: tokenSecret!)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            self.results = response as NSDictionary?
            self.resultsTableView.reloadData()
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        })
        
        resultsTableView.estimatedRowHeight = 150
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = results {
            return (results["businesses"] as NSArray).count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.ResultCell") as ResultTableViewCell
        
        //parse out all the data (wish SwiftyJSON and BDBOAuth didn't blow up together)
        let result = (results!["businesses"] as NSArray)[indexPath.row] as NSDictionary
        let resultName = result["name"] as String
        let resultImageURL = result["image_url"]! as String
        let resultDistance = result["distance"] as Float
        let resultFormattedDistance = NSString(format: "%.2f", resultDistance / 5280.0)
        let resultRatingURL = result["rating_img_url"]! as String
        let resultReviewerCount = result["review_count"]! as Int
        let resultPrice = "$?"
        let resultAddress = ((result["location"] as NSDictionary)["address"] as NSArray)[0] as String
        var resultCategories: [String] = []
        for category in (result["categories"] as NSArray) as NSArray {
            resultCategories += [category[0]! as String]
        }

        // set all the props
        cell.resultTitleLabel.text = "\(indexPath.row + 1). \(resultName)"
        cell.resultImageView.setImageWithURL(NSURL(string: resultImageURL))
        cell.resultDistanceLabel.text = "\(resultFormattedDistance) mi"
        cell.resultRatingImageView.setImageWithURL(NSURL(string: resultRatingURL))
        cell.resultReviewerCountLabel.text = "\(resultReviewerCount) Reviews"
        cell.resultPriceLabel.text = resultPrice
        cell.resultAddressLabel.text = resultAddress
        cell.resultCategoriesLabel.text = ", ".join(resultCategories)
        
        // style some stuff
        cell.resultImageView.layer.cornerRadius = 10;
        cell.resultImageView.clipsToBounds = true;
        
        return cell
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

