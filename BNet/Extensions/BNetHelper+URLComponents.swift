//
//  BNetHelper+URLComponents.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation

extension URLComponents {
    /// Helper function is responsible for adding the query parameters to request by using URLComponents
    ///
    /// - Parameter parameters: Query parameters
    mutating func setQueryItems(from parameters: Parameters) {
        self.queryItems = []
        for (key, value) in parameters {
            if let val = value as? String {
                let encodedForURL = val.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let item = URLQueryItem(name: key, value: encodedForURL)
                self.queryItems?.append(item)
            }
        }
    }
}
