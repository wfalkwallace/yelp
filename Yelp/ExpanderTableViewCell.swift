//
//  ExpanderTableViewCell.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class ExpanderTableViewCell: UITableViewCell {

    @IBOutlet weak var expanderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
