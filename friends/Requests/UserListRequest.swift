//
//  UserListRequest.swift
//  friends
//
//  Created by Ashraf Uddin on 28/3/23.
//

import Foundation
struct UserListRequest: DataRequest {
    typealias Response = [User]
    
    let limit = 10
    
    var url: String {
        return FriendsNetworkService.baseUrl
    }
    
    var queryItems: [String : String] {
        return ["results": "\(limit)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    func decode(_ data: Data) throws -> [User] {
        let decoder = JSONDecoder()
        let response = try decoder.decode(UserResponse.self, from: data)
        return response.results
    }
}
