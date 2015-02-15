//
//  Result.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/13/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class Result {
    
    var resultName: String
    var resultImageURL: String
    var resultDistance: Float
    var resultRatingURL: String
    var resultReviewerCount: Int
    var resultAddress: String
    var resultCategories: [String]
    var resultFormattedDistance: String {
        return NSString(format: "%.2f", resultDistance / 1609.34)
    }
    
    init(resultName: String,
        resultImageURL: String,
        resultDistance: Float,
        resultRatingURL: String,
        resultReviewerCount: Int,
        resultAddress: String,
        resultCategories: [String]) {
            self.resultName = resultName
            self.resultImageURL = resultImageURL
            self.resultDistance = resultDistance
            self.resultRatingURL = resultRatingURL
            self.resultReviewerCount = resultReviewerCount
            self.resultAddress = resultAddress
            self.resultCategories = resultCategories
    }
    
    class func resultArrayFromDictionary(response: NSArray) -> [Result] {
        var results: [Result] = []
        for result in response {
            var resultName = result["name"] as String
            var resultImageURL = result["image_url"]! as String
            var resultDistance = result["distance"] as Float
            var resultRatingURL = result["rating_img_url"]! as String
            var resultReviewerCount = result["review_count"]! as Int
            var resultAddress = (result["location"] as NSDictionary)["address"] as NSArray
            var resultDisplayAddress = resultAddress.count > 0 ? resultAddress[0] as String : ""
            var resultCategories = (result["categories"]! as [[String]]).map({
                $0[0] as String
            })
            
            results.append(Result(resultName: resultName,
                                  resultImageURL: resultImageURL,
                                  resultDistance: resultDistance,
                                  resultRatingURL: resultRatingURL,
                                  resultReviewerCount: resultReviewerCount,
                                  resultAddress: resultDisplayAddress,
                                  resultCategories: resultCategories))
        }
        
        return results
    }
}
