//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func search(searchParameters: [String:String?],
                success: (AFHTTPRequestOperation!, AnyObject!) -> Void,
                failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
            var parameters = Dictionary<String, String>()
            if let term = searchParameters["term"] {
                parameters["term"] = term
            }
            if let categories = searchParameters["categories"] {
                parameters["category_filter"] = categories
            }
            if let radius = searchParameters["radius"] {
                parameters["radius_filter"] = radius
            }
            if let location = searchParameters["location"] {
                parameters["ll"] = location
            } else {
                parameters["ll"] = "37.791412, -122.395606"
            }
            return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
}


