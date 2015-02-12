//
//  ViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var client: YelpClient!
    
    var consumerKey: String?
    var consumerSecret: String?
    var token: String?
    var tokenSecret: String?
    
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
            println(response)
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

