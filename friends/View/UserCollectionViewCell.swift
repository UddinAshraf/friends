//
//  UserCollectionViewCell.swift
//  friends
//
//  Created by Ashraf Uddin on 29/3/23.
//

import UIKit

struct UserCollectionViewCellConstant {
    static let userPerRow: CGFloat = 4
    static let itemSpacing: CGFloat = 60.0
    static let height: CGFloat = 400.0
}
class UserCollectionViewCell: UICollectionViewCell {
    static let identifier = "UserCollectionViewCell"
    
    @IBOutlet weak var userPotraitImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userPotraitImageView.image = nil
        fullnameLabel.text = ""
        countryLabel.text = ""
    }
    
    func configure(with user: User) {
        
        userPotraitImageView.clipsToBounds = true
        userPotraitImageView.layer.cornerRadius = 20.0
        userPotraitImageView.backgroundColor = .gray
        if let imageUrl = user.picture?.large {
            FriendsImageService.shared.setImage(from: imageUrl, placeholderImage: nil) { [weak self] image in
                if let image = image, let self = self {
                    self.userPotraitImageView.image = image
                }
            }
        }
        if let name = user.name {
            fullnameLabel.text = "\(name.title ?? "") \(name.first ?? "") \(name.last ?? "")"
        }
        countryLabel.text = user.location?.country ?? ""
    }
}
