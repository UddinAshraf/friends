//
//  FriendsImageRequest.swift
//  friends
//
//  Created by Ashraf Uddin on 29/3/23.
//

import Foundation
import UIKit

struct FriendsImageRequest: DataRequest {
    
    let url: String
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NSError(
                domain: ErrorResponse.invalidResponse.rawValue,
                code: 13,
                userInfo: nil
            )
        }
        
        return image
    }
}
