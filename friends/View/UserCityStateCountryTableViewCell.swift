//
//  UserCityStateCountryTableViewCell.swift
//  friends
//
//  Created by Ashraf Uddin on 30/3/23.
//

import UIKit
class UserCityStateCountryTableViewCell: UITableViewCell {
    static let identifier = "UserCityStateCountryTableViewCell"
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
