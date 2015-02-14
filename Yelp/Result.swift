//
//  Result.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/13/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class Result {
    
    let resultName: String
    let resultImageURL: String
    let resultDistance: Float
    let resultRatingURL: String
    let resultReviewerCount: Int
    let resultAddress: String
    let resultCategories: String
    var resultFormattedDistance: String {
        return NSString(format: "%.2f", resultDistance / 1609.34)
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
