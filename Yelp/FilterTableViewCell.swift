//
//  FilterTableViewCell.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FilterTableViewCellDelegate: class {
    func filterTableViewCell(filterTableViewCell: FilterTableViewCell,
        switchValueDidChange value: Bool)
}

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    var filter: [String:String]! {
        didSet {
            filterLabel.text = filter["name"]
        }
    }
    weak var delegate: FilterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueDidChange(sender: AnyObject) {
        delegate?.filterTableViewCell(self, switchValueDidChange: filterSwitch.on)
    }
}
