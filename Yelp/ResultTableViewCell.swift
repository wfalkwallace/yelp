//
//  ResultTableViewCell.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    var result: Result!
    var resultNumber: Int!
    
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultDistanceLabel: UILabel!
    @IBOutlet weak var resultRatingImageView: UIImageView!
    @IBOutlet weak var resultReviewerCountLabel: UILabel!
    @IBOutlet weak var resultAddressLabel: UILabel!
    @IBOutlet weak var resultCategoriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        resultImageView.image = nil
        
        // set all the props
        resultTitleLabel.text = "\(resultNumber). \(result.resultName)"
        resultImageView.setImageWithURL(NSURL(string: result.resultImageURL))
        resultDistanceLabel.text = "\(result.resultFormattedDistance) mi"
        resultRatingImageView.setImageWithURL(NSURL(string: result.resultRatingURL))
        resultReviewerCountLabel.text = "\(result.resultReviewerCount) Reviews"
        resultAddressLabel.text = result.resultAddress
        resultCategoriesLabel.text = result.resultCategories
        
        // style some stuff
        resultImageView.layer.cornerRadius = 10;
        resultImageView.clipsToBounds = true;
        
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
