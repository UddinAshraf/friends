//
//  FriendsImageService.swift
//  friends
//
//  Created by Ashraf Uddin on 29/3/23.
//

import UIKit

protocol FriendsImageServiceProtocol {
    func downloadImage<Request: DataRequest>(request: Request, completion: @escaping (UIImage?, Error?) -> Void)
    func setImage(from url: String, placeholderImage: UIImage?, completion: @escaping (UIImage?) -> Void)
}

final class FriendsImageService {
    
    static let shared = FriendsImageService(
        responseQueue: .main,
        session: URLSession.shared
    )
    
    private(set) var cachedImageForURL: [String: UIImage]
    private(set) var cachedTaskForImageView: [UIImageView : NetworkService]
    
    let responseQueue: DispatchQueue?
    let session: URLSession
    
    init(responseQueue: DispatchQueue?, session: URLSession) {
        self.cachedImageForURL = [:]
        self.cachedTaskForImageView = [:]
        
        self.responseQueue = responseQueue
        self.session = session
    }
    
    private func dispatchImage(
        image: UIImage? = nil,
        error: Error? = nil,
        completion: @escaping (UIImage?, Error?
        ) -> Void) {
        
        guard let responseQueue = responseQueue else {
            completion(image, error)
            return
        }
        
        responseQueue.async {
            completion(image, error)
        }
    }
}

extension FriendsImageService: FriendsImageServiceProtocol {
    func downloadImage<Request: DataRequest>(request: Request, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let service: NetworkService = FriendsNetworkService()
        
        service.request(request) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                guard let image: UIImage = response as? UIImage else {
                    return
                }
                
                self.dispatchImage(image: image, completion: completion)
            case .failure(let error):
                self.dispatchImage(error: error, completion: completion)
            }
        }
    }
    
    
    
    func setImage(from url: String, placeholderImage: UIImage?, completion: @escaping (UIImage?) -> Void) {
        let request = FriendsImageRequest(url: url)
        if let cacheImage = cachedImageForURL[url] {
            completion(cacheImage)
        } else {
            downloadImage(request: request) { [weak self] image, error in
                guard let self = self else {
                    return
                }
                
                guard let image = image else {
                    return
                }
                
                self.cachedImageForURL[url] = image
                completion(self.cachedImageForURL[url])
            }
        }
    }
}
