//
//  Collection+Extension.swift
//  friends
//
//  Created by Ashraf Uddin on 29/3/23.
//

import Foundation
extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
