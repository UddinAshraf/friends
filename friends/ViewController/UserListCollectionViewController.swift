//
//  UserListCollectionViewController.swift
//  friends
//
//  Created by Ashraf Uddin on 28/3/23.
//

import UIKit

class UserListCollectionViewController: UIViewController {
    
    @IBOutlet weak var userListCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = UserListViewModel(networkService: FriendsNetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Your friends list"
        activityIndicator.startAnimating()
        viewModel.fetchUsers()
        bindData()
    }
    
    func bindData() {
        viewModel.onUserListFetchedSucceed = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.userListCollectionView.reloadData()
            }
        }
        
        viewModel.onUserListFetchedFailed = { [weak self] error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                let alert = UIAlertController(title: "Error!!", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
            }
        }
    }
}

//MARK: UICollectionViewDataSource & UICollectionViewDelegate methods
extension UserListCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.identifier, for: indexPath) as? UserCollectionViewCell, let user = viewModel.users[safe: indexPath.item] else { return UICollectionViewCell() }
        
        cell.configure(with: user)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalWidth = UIScreen.main.bounds.width - UserCollectionViewCellConstant.itemSpacing
        let itemWidth = totalWidth / UserCollectionViewCellConstant.userPerRow
        return CGSize(width: itemWidth, height: UserCollectionViewCellConstant.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let user = self.viewModel.users[safe: indexPath.item] else { return }
        let viewModel = UserDetailViewModel(user: user)
        guard let userDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailsViewController") as? UserDetailsViewController else { return }
        userDetailsViewController.viewModel = viewModel
        self.navigationController?.pushViewController(userDetailsViewController, animated: true)
    }
}
