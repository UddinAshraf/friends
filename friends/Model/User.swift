//
//  User.swift
//  friends
//
//  Created by Ashraf Uddin on 28/3/23.
//

import Foundation

struct UserResponse: Codable {
    let results : [User]
}

struct User: Codable {
    let gender: String?
    let name: UserName?
    let location: UserLocation?
    let email: String?
    let cell: String?
    let picture: UserPicture?
}

struct UserName: Codable {
    let title: String?
    let first: String?
    let last: String?
}

struct UserLocation: Codable {
    let street: LocationStreet?
    let city: String?
    let state: String?
    let country: String?
    let coordinates: LocationCoordinates?
}

struct LocationStreet: Codable {
    let number: Int?
    let name: String?
}

struct LocationCoordinates: Codable {
    let latitude: String?
    let longitude: String?
}

struct UserPicture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
