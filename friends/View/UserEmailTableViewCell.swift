//
//  UserEmailTableViewCell.swift
//  friends
//
//  Created by Ashraf Uddin on 30/3/23.
//

import UIKit

protocol UserEmailTableViewCellDelegate: AnyObject {
    func didClikedEmail(email: String)
}
class UserEmailTableViewCell: UITableViewCell {
    static let identifier = "UserEmailTableViewCell"
    
    weak var delegate: UserEmailTableViewCellDelegate?
    @IBOutlet weak var emailTextView: UITextView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with mail: String) {
        self.emailTextView.delegate = self
        let attributedString = NSMutableAttributedString(string: mail)
        guard let mailUrl = URL(string: mail) else { return }
        attributedString.setAttributes([.link: mailUrl], range: NSMakeRange(0, mail.count))
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20, weight: .bold), range: NSMakeRange(0, mail.count))
        self.emailTextView.attributedText = attributedString
        self.emailTextView.isUserInteractionEnabled = true
        self.emailTextView.isEditable = false
        
        self.emailTextView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
}


//MARK: UITextViewDelegate methods

extension UserEmailTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        delegate?.didClikedEmail(email: URL.path)
        return true
    }
}
