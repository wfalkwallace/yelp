//
//  ResultTableViewCell.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultDistanceLabel: UILabel!
    @IBOutlet weak var resultRatingImageView: UIImageView!
    @IBOutlet weak var resultReviewerCountLabel: UILabel!
    @IBOutlet weak var resultPriceLabel: UILabel!
    @IBOutlet weak var resultAddressLabel: UILabel!
    @IBOutlet weak var resultCategoriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
