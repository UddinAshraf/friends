//
//  UserDetailViewModel.swift
//  friends
//
//  Created by Ashraf Uddin on 30/3/23.
//

import Foundation
import CoreLocation

class UserDetailViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getFullName() -> String {
        guard let name = user.name  else { return "" }
        return "\(name.title ?? "") \(name.first ?? "") \(name.last ?? "")"
        
    }
    
    func getCellPhone() -> String {
        guard let cellPhone = user.cell else { return ""}
        return cellPhone
    }
    
    
    
    func getAddress(handler: @escaping (String) -> Void)
    {
        guard let lat = user.location?.coordinates?.latitude, let lon = user.location?.coordinates?.longitude, let  selectedLat = Double(lat),  let selectedLon = Double(lon) else {
            handler("not found")
            return
        }
        
        var address: String = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: selectedLat, longitude: selectedLon)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark?
            placeMark = placemarks?[0]
            if let locationName = placeMark?.name {
                address += locationName + ", "
            }
            if let street = placeMark?.thoroughfare {
                address += street + ", "
            }
            if let city = placeMark?.locality {
                address += city + ", "
            }
            if let zip = placeMark?.postalCode {
                address += zip + ", "
            }

            if let country = placeMark?.country {
                address += country
            }
           handler(address)
        })
    }
    
    enum UserInfo: Int, CaseIterable {
        case fullname
        case address
        case stateCityCountry
        case email
        case cellPhone
        
        var title: String {
            switch self {
            case .fullname:
                return "Full Name"
            case .address:
                return "Address"
            case .stateCityCountry:
                return ""
            case .email:
                return "Email"
            case .cellPhone:
                return "Cell Phone"
            }
        }
    }
}

