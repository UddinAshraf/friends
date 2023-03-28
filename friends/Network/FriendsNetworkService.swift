//
//  FriendsNetworkService.swift
//  friends
//
//  Created by Ashraf Uddin on 28/3/23.
//

import Foundation

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}


final class FriendsNetworkService: NetworkService {
    static let baseUrl = "https://randomuser.me/api/"
    
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            let error = NSError(domain: ErrorResponse.invalidEndpoint.rawValue, code: 404, userInfo: nil)
            return completion(.failure(error))
        }
        let queryItems: [URLQueryItem] = request.queryItems.map { item -> URLQueryItem in
            return URLQueryItem(name: item.key, value: item.value)
        }
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            let error = NSError(domain: ErrorResponse.invalidEndpoint.rawValue, code: 404, userInfo: nil)
            return completion(.failure(error))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                let error = NSError(domain: ErrorResponse.invalidResponse.rawValue, code: 400, userInfo: nil)
                return completion(.failure(error))
            }
            
            guard let data = data else {
                let error = NSError(domain: ErrorResponse.noData.rawValue, code: 400, userInfo: nil)
                return completion(.failure(error))
            }
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NSError {
                completion(.failure(error))
            }
        }.resume()
    }

}
