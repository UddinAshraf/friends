//
//  UserEmailTableViewCell.swift
//  friends
//
//  Created by Ashraf Uddin on 30/3/23.
//

import UIKit
class UserEmailTableViewCell: UITableViewCell {
    static let identifier = "UserEmailTableViewCell"
    
    @IBOutlet weak var emailTextView: UITextView!
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

