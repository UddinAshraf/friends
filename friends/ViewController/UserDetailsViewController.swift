//
//  UserDetailsViewController.swift
//  friends
//
//  Created by Ashraf Uddin on 30/3/23.
//

import UIKit
import MessageUI

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userInfoTableView: UITableView!
    
    var viewModel: UserDetailViewModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpImage()
    }
    
    fileprivate func setUpImage() {
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 20.0
        userImageView.backgroundColor = .gray
        if let imageUrl = viewModel?.user.picture?.large {
            FriendsImageService.shared.setImage(from: imageUrl, placeholderImage: nil) { [weak self] image in
                if let image = image, let self = self {
                    self.userImageView.image = image
                }
            }
        }
    }
}


//MARK: UITableViewDatasource method
extension UserDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDetailViewModel.UserInfo.allCases.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let infoType = UserDetailViewModel.UserInfo(rawValue: indexPath.row) else { return UITableViewCell() }
        switch infoType {
        case .stateCityCountry:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCityStateCountryTableViewCell.identifier, for: indexPath) as?  UserCityStateCountryTableViewCell else { return UITableViewCell() }
            cell.stateLabel.text = viewModel?.user.location?.state
            cell.cityLabel.text = viewModel?.user.location?.city
            cell.countryLabel.text = viewModel?.user.location?.country
            return cell
            
        case .email:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserEmailTableViewCell.identifier, for: indexPath) as?  UserEmailTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: viewModel?.user.email ?? "")
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier, for: indexPath) as?  UserInfoTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = infoType.title
            
            switch infoType {
            case .fullname:
                cell.valueLabel.text = viewModel?.getFullName()
            case .address:
                 viewModel?.getAddress { address in
                     cell.valueLabel.text = address
                    
                }
            case .cellPhone:
                cell.valueLabel.text = viewModel?.getCellPhone()
            default:
                print("NO NEED")
            }
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

//MARK: UserEmailTableViewCellDelegate method
extension UserDetailsViewController: UserEmailTableViewCellDelegate {
    func didClikedEmail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            let recipients = [email]
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(recipients)
            mailVC.setMessageBody("<p>Hi Frinds!</p>", isHTML: true)
            
            present(mailVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Error!!", message: "Something wrong happend please try again later!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
}

//MARK: UserEmailTableViewCellDelegate method
extension UserDetailsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
   
