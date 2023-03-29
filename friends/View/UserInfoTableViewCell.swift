//
//  UserInfoTableViewCell.swift
//  friends
//
//  Created by Ashraf Uddin on 30/3/23.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    static let identifier = "UserInfoTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
