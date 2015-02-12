//
//  ViewController.swift
//  howl
//
//  Created by William Falk-Wallace on 2/11/15.
//  Copyright (c) 2015 Falk-Wallace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var client: YelpClient!
    
    let consumerKey = NSBundle.mainBundle().objectForInfoDictionaryKey("CONSUMER_KEY") as NSString
    let consumerSecret = NSBundle.mainBundle().objectForInfoDictionaryKey("CONSUMER_SECRET") as NSString
    let token = NSBundle.mainBundle().objectForInfoDictionaryKey("TOKEN") as NSString
    let tokenSecret = NSBundle.mainBundle().objectForInfoDictionaryKey("TOKEN_SECRET") as NSString
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = YelpClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: token, accessSecret: tokenSecret)
        
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
