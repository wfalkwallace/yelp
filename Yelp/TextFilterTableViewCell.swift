//
//  TextFilterTableViewCell.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class TextFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterName: UIView!
    @IBOutlet weak var filterValue: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
