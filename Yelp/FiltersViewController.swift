//
//  FiltersViewController.swift
//  Yelp
//
//  Created by William Falk-Wallace on 2/14/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate: class {
    func filtersViewController(filtersViewController: FiltersViewController,
                               categories: [String],
                               deals: Bool,
                               radius: (String, Float?),
                               sort: Int)
}

class FiltersViewController: UIViewController,
                             UITableViewDataSource,
                             UITableViewDelegate,
                             FilterTableViewCellDelegate {

    @IBOutlet weak var filtersTableView: UITableView!
    weak var delegate: FiltersViewControllerDelegate?
    
    var categoryFilters: [String] = []
    var dealFilter: Bool = false
    var radiusFilter: (String,Float?) = ("Best Match", nil)
    var sortFilter = 0
    var expand:String = "" {
        didSet {
            switch expand {
            case "Categories":
                sectionRows["Categories"] = categories.count
                sectionRows["Sort"] = 1
                sectionRows["Distance"] = 1
            case "Sort":
                self.sectionRows["Categories"] = 4
                self.sectionRows["Sort"] = sorts.count
                self.sectionRows["Distance"] = 1
            case "Distance":
                self.sectionRows["Categories"] = 4
                self.sectionRows["Sort"] = 1
                self.sectionRows["Distance"] = radii.count
            default:
                self.sectionRows["Categories"] = 4
                self.sectionRows["Sort"] = 1
                self.sectionRows["Distance"] = 1
            }
            self.filtersTableView.reloadData()
        }
    }
    
    let sections = ["Sort", "Distance", "Popular", "Categories"]
    var sectionRows = ["Sort": 1, "Distance": 1, "Popular": 1, "Categories": 4]
    let sorts: [String] = ["Best Match",
                           "Distance",
                           "Rating"]
    let sortValues: [String:Int] = ["Best Match": 0,
                                    "Distance": 1,
                                    "Rating": 2]
    let radii: [String] = ["Best Match",
                           "2 blocks",
                           "6 blocks",
                           "1 mile",
                           "5 miles"]
    let radiusValues: [String:Float?] = ["Best Match": nil,
                                         "2 blocks": 200.0,
                                         "6 blocks": 600.0,
                                         "1 mile": 1609.34,
                                         "5 miles": 8046.72]
    let popular: [String] = ["Deals"]
    let categories: [[String:String]] = [["name" : "Afghan", "code": "afghani"],
                                        ["name" : "African", "code": "african"],
                                        ["name" : "American, New", "code": "newamerican"],
                                        ["name" : "American, Traditional", "code": "tradamerican"],
                                        ["name" : "Arabian", "code": "arabian"],
                                        ["name" : "Argentine", "code": "argentine"],
                                        ["name" : "Armenian", "code": "armenian"],
                                        ["name" : "Asian Fusion", "code": "asianfusion"],
                                        ["name" : "Asturian", "code": "asturian"],
                                        ["name" : "Australian", "code": "australian"],
                                        ["name" : "Austrian", "code": "austrian"],
                                        ["name" : "Baguettes", "code": "baguettes"],
                                        ["name" : "Bangladeshi", "code": "bangladeshi"],
                                        ["name" : "Barbeque", "code": "bbq"],
                                        ["name" : "Basque", "code": "basque"],
                                        ["name" : "Bavarian", "code": "bavarian"],
                                        ["name" : "Beer Garden", "code": "beergarden"],
                                        ["name" : "Beer Hall", "code": "beerhall"],
                                        ["name" : "Beisl", "code": "beisl"],
                                        ["name" : "Belgian", "code": "belgian"],
                                        ["name" : "Bistros", "code": "bistros"],
                                        ["name" : "Black Sea", "code": "blacksea"],
                                        ["name" : "Brasseries", "code": "brasseries"],
                                        ["name" : "Brazilian", "code": "brazilian"],
                                        ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                                        ["name" : "British", "code": "british"],
                                        ["name" : "Buffets", "code": "buffets"],
                                        ["name" : "Bulgarian", "code": "bulgarian"],
                                        ["name" : "Burgers", "code": "burgers"],
                                        ["name" : "Burmese", "code": "burmese"],
                                        ["name" : "Cafes", "code": "cafes"],
                                        ["name" : "Cafeteria", "code": "cafeteria"],
                                        ["name" : "Cajun/Creole", "code": "cajun"],
                                        ["name" : "Cambodian", "code": "cambodian"],
                                        ["name" : "Canadian", "code": "New)"],
                                        ["name" : "Canteen", "code": "canteen"],
                                        ["name" : "Caribbean", "code": "caribbean"],
                                        ["name" : "Catalan", "code": "catalan"],
                                        ["name" : "Chech", "code": "chech"],
                                        ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                                        ["name" : "Chicken Shop", "code": "chickenshop"],
                                        ["name" : "Chicken Wings", "code": "chicken_wings"],
                                        ["name" : "Chilean", "code": "chilean"],
                                        ["name" : "Chinese", "code": "chinese"],
                                        ["name" : "Comfort Food", "code": "comfortfood"],
                                        ["name" : "Corsican", "code": "corsican"],
                                        ["name" : "Creperies", "code": "creperies"],
                                        ["name" : "Cuban", "code": "cuban"],
                                        ["name" : "Curry Sausage", "code": "currysausage"],
                                        ["name" : "Cypriot", "code": "cypriot"],
                                        ["name" : "Czech", "code": "czech"],
                                        ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                                        ["name" : "Danish", "code": "danish"],
                                        ["name" : "Delis", "code": "delis"],
                                        ["name" : "Diners", "code": "diners"],
                                        ["name" : "Dumplings", "code": "dumplings"],
                                        ["name" : "Eastern European", "code": "eastern_european"],
                                        ["name" : "Ethiopian", "code": "ethiopian"],
                                        ["name" : "Fast Food", "code": "hotdogs"],
                                        ["name" : "Filipino", "code": "filipino"],
                                        ["name" : "Fish & Chips", "code": "fishnchips"],
                                        ["name" : "Fondue", "code": "fondue"],
                                        ["name" : "Food Court", "code": "food_court"],
                                        ["name" : "Food Stands", "code": "foodstands"],
                                        ["name" : "French", "code": "french"],
                                        ["name" : "French Southwest", "code": "sud_ouest"],
                                        ["name" : "Galician", "code": "galician"],
                                        ["name" : "Gastropubs", "code": "gastropubs"],
                                        ["name" : "Georgian", "code": "georgian"],
                                        ["name" : "German", "code": "german"],
                                        ["name" : "Giblets", "code": "giblets"],
                                        ["name" : "Gluten-Free", "code": "gluten_free"],
                                        ["name" : "Greek", "code": "greek"],
                                        ["name" : "Halal", "code": "halal"],
                                        ["name" : "Hawaiian", "code": "hawaiian"],
                                        ["name" : "Heuriger", "code": "heuriger"],
                                        ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                                        ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                                        ["name" : "Hot Dogs", "code": "hotdog"],
                                        ["name" : "Hot Pot", "code": "hotpot"],
                                        ["name" : "Hungarian", "code": "hungarian"],
                                        ["name" : "Iberian", "code": "iberian"],
                                        ["name" : "Indian", "code": "indpak"],
                                        ["name" : "Indonesian", "code": "indonesian"],
                                        ["name" : "International", "code": "international"],
                                        ["name" : "Irish", "code": "irish"],
                                        ["name" : "Island Pub", "code": "island_pub"],
                                        ["name" : "Israeli", "code": "israeli"],
                                        ["name" : "Italian", "code": "italian"],
                                        ["name" : "Japanese", "code": "japanese"],
                                        ["name" : "Jewish", "code": "jewish"],
                                        ["name" : "Kebab", "code": "kebab"],
                                        ["name" : "Korean", "code": "korean"],
                                        ["name" : "Kosher", "code": "kosher"],
                                        ["name" : "Kurdish", "code": "kurdish"],
                                        ["name" : "Laos", "code": "laos"],
                                        ["name" : "Laotian", "code": "laotian"],
                                        ["name" : "Latin American", "code": "latin"],
                                        ["name" : "Live/Raw Food", "code": "raw_food"],
                                        ["name" : "Lyonnais", "code": "lyonnais"],
                                        ["name" : "Malaysian", "code": "malaysian"],
                                        ["name" : "Meatballs", "code": "meatballs"],
                                        ["name" : "Mediterranean", "code": "mediterranean"],
                                        ["name" : "Mexican", "code": "mexican"],
                                        ["name" : "Middle Eastern", "code": "mideastern"],
                                        ["name" : "Milk Bars", "code": "milkbars"],
                                        ["name" : "Modern Australian", "code": "modern_australian"],
                                        ["name" : "Modern European", "code": "modern_european"],
                                        ["name" : "Mongolian", "code": "mongolian"],
                                        ["name" : "Moroccan", "code": "moroccan"],
                                        ["name" : "New Zealand", "code": "newzealand"],
                                        ["name" : "Night Food", "code": "nightfood"],
                                        ["name" : "Norcinerie", "code": "norcinerie"],
                                        ["name" : "Open Sandwiches", "code": "opensandwiches"],
                                        ["name" : "Oriental", "code": "oriental"],
                                        ["name" : "Pakistani", "code": "pakistani"],
                                        ["name" : "Parent Cafes", "code": "eltern_cafes"],
                                        ["name" : "Parma", "code": "parma"],
                                        ["name" : "Persian/Iranian", "code": "persian"],
                                        ["name" : "Peruvian", "code": "peruvian"],
                                        ["name" : "Pita", "code": "pita"],
                                        ["name" : "Pizza", "code": "pizza"],
                                        ["name" : "Polish", "code": "polish"],
                                        ["name" : "Portuguese", "code": "portuguese"],
                                        ["name" : "Potatoes", "code": "potatoes"],
                                        ["name" : "Poutineries", "code": "poutineries"],
                                        ["name" : "Pub Food", "code": "pubfood"],
                                        ["name" : "Rice", "code": "riceshop"],
                                        ["name" : "Romanian", "code": "romanian"],
                                        ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                                        ["name" : "Rumanian", "code": "rumanian"],
                                        ["name" : "Russian", "code": "russian"],
                                        ["name" : "Salad", "code": "salad"],
                                        ["name" : "Sandwiches", "code": "sandwiches"],
                                        ["name" : "Scandinavian", "code": "scandinavian"],
                                        ["name" : "Scottish", "code": "scottish"],
                                        ["name" : "Seafood", "code": "seafood"],
                                        ["name" : "Serbo Croatian", "code": "serbocroatian"],
                                        ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                                        ["name" : "Singaporean", "code": "singaporean"],
                                        ["name" : "Slovakian", "code": "slovakian"],
                                        ["name" : "Soul Food", "code": "soulfood"],
                                        ["name" : "Soup", "code": "soup"],
                                        ["name" : "Southern", "code": "southern"],
                                        ["name" : "Spanish", "code": "spanish"],
                                        ["name" : "Steakhouses", "code": "steak"],
                                        ["name" : "Sushi Bars", "code": "sushi"],
                                        ["name" : "Swabian", "code": "swabian"],
                                        ["name" : "Swedish", "code": "swedish"],
                                        ["name" : "Swiss Food", "code": "swissfood"],
                                        ["name" : "Tabernas", "code": "tabernas"],
                                        ["name" : "Taiwanese", "code": "taiwanese"],
                                        ["name" : "Tapas Bars", "code": "tapas"],
                                        ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                                        ["name" : "Tex-Mex", "code": "tex-mex"],
                                        ["name" : "Thai", "code": "thai"],
                                        ["name" : "Traditional Norwegian", "code": "norwegian"],
                                        ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                                        ["name" : "Trattorie", "code": "trattorie"],
                                        ["name" : "Turkish", "code": "turkish"],
                                        ["name" : "Ukrainian", "code": "ukrainian"],
                                        ["name" : "Uzbek", "code": "uzbek"],
                                        ["name" : "Vegan", "code": "vegan"],
                                        ["name" : "Vegetarian", "code": "vegetarian"],
                                        ["name" : "Venison", "code": "venison"],
                                        ["name" : "Vietnamese", "code": "vietnamese"],
                                        ["name" : "Wok", "code": "wok"],
                                        ["name" : "Wraps", "code": "wraps"],
                                        ["name" : "Yugoslav", "code": "yugoslav"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onApplyButton(sender: AnyObject) {
        delegate?.filtersViewController(self, categories: categoryFilters, deals: dealFilter, radius: radiusFilter, sort: sortFilter)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = sectionRows[sections[section]] {
            return rows
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let sectionName = sections[section]
        
        switch sectionName {
        case "Sort":
            if expand != "Sort" {
                let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.TextFilterCell") as TextFilterTableViewCell
                cell.filterName.text = sorts[sortFilter]
                return cell
            } else {
                let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.TextFilterCell") as TextFilterTableViewCell
                cell.filterName.text = sorts[row]
                return cell
            }
        case "Distance":
            if expand != "Distance" {
                let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.TextFilterCell") as TextFilterTableViewCell
                cell.filterName.text = radiusFilter.0
                return cell
            } else {
                let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.TextFilterCell") as TextFilterTableViewCell
                cell.filterName.text = radii[row]
                return cell
            }
        case "Popular":
            let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.FilterCell") as FilterTableViewCell
            cell.filter = ["name": "Deals", "code": "deals"]
            cell.filterSwitch.on = dealFilter
            cell.delegate = self
            return cell
        case "Categories":
            if expand != "Categories" && row == sectionRows[sectionName]! - 1 {
                let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.ExpanderCell") as ExpanderTableViewCell
                cell.expanderLabel.text = "Show More"
                return cell
            } else {
                let cell = filtersTableView.dequeueReusableCellWithIdentifier("com.falk-wallace.FilterCell") as FilterTableViewCell
                let filter = categories[indexPath.row]
                cell.filter = filter
                cell.filterSwitch.on = find(categoryFilters, filter["code"]!) != nil
                cell.delegate = self
                return cell
            }
        // Should never see either of these cases - what's the better way to do this?
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch sections[indexPath.section ] {
        case "Categories":
            if expand != "Categories" && indexPath.row == sectionRows.count - 1{
                expand = "Categories"
            }
        case "Sort":
            if expand != "Sort" {
                expand = "Sort"
            } else {
                sortFilter = sortValues[sorts[indexPath.row]]!
                expand = ""
            }
        case "Distance":
            if expand != "Distance" {
                expand = "Distance"
            } else {
                radiusFilter = (radii[indexPath.row], radiusValues[radii[indexPath.row]]!)
                expand = ""
            }
        default:
            expand = ""
        }
    }
    
    func filterTableViewCell(filterTableViewCell: FilterTableViewCell, switchValueDidChange value: Bool) {
        if let filterCode = filterTableViewCell.filter["code"] {
            if value {
                if filterCode == "deals" {
                    dealFilter = true
                } else {
                    categoryFilters.append(filterCode)
                }
            } else if filterCode == "deals" {
                dealFilter = false
            }else if let index = find(categoryFilters, filterTableViewCell.filter["code"]!) {
                categoryFilters.removeAtIndex(index)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
