//
//  UserListCollectionViewController.swift
//  friends
//
//  Created by Ashraf Uddin on 28/3/23.
//

import UIKit

class UserListCollectionViewController: UIViewController {

    let viewModel = UserListViewModel(networkService: FriendsNetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchUsers()
    }


}
