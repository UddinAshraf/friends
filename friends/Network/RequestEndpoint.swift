//
//  Request.swift
//  friends
//
//  Created by Ashraf Uddin on 28/3/23.
//

import Foundation

enum HTTPMethod: String  {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol DataRequest {
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String : String] { get }
    func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

extension DataRequest {
    var headers: [String : String] {
        return [:]
    }
    
    var queryItems: [String : String] {
        return [:]
    }
}
