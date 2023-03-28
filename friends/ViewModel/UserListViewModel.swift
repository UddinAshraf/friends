//
//  UserViewModel.swift
//  friends
//
//  Created by Ashraf Uddin on 28/3/23.
//

import Foundation

protocol UserListViewModelProtocol: AnyObject {
    var users: [User] { set get }
    var onUserListFetchedSucceed: (() -> Void)? { set get }
    var onUserListFetchedFailed: ((Error) -> Void)? { set get }
    func fetchUsers()
}

class UserListViewModel: UserListViewModelProtocol {
    
    private let networkService: FriendsNetworkService
    
    init(networkService: FriendsNetworkService) {
        self.networkService = networkService
    }
    
    var users: [User] = []
    var onUserListFetchedSucceed: (() -> Void)?
    var onUserListFetchedFailed: ((Error) -> Void)?
    
    func fetchUsers() {
        let request = UserListRequest()
        networkService.request(request) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let users):
                weakSelf.users = users
                weakSelf.onUserListFetchedSucceed?()
            case .failure(let error):
                weakSelf.onUserListFetchedFailed?(error)
            }
        }
    }
    
    
}
