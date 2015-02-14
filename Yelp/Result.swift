//
//  Result.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/13/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class Result {
    
    var resultName: String!
    var resultImageURL: String!
    var resultDistance: Float!
    var resultRatingURL: String!
    var resultReviewerCount: Int!
    var resultAddress: String!
    var resultCategories: String!
    var resultFormattedDistance: String {
        get {
            return NSString(format: "%.2f", resultDistance / 1609.34)
        }
    }
    
    
    init(resultName: String,
        resultImageURL: String,
        resultDistance: Float,
        resultRatingURL: String,
        resultReviewerCount: Int,
        resultAddress: String,
        resultCategories: String) {
            self.resultName = resultName
            self.resultImageURL = resultImageURL
            self.resultDistance = resultDistance
            self.resultRatingURL = resultRatingURL
            self.resultReviewerCount = resultReviewerCount
            self.resultAddress = resultAddress
            self.resultCategories = resultCategories
    }
}
