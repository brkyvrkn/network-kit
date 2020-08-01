//
//  BNetEncoders.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation

/// Encode the Parameters of given URLRequest object
///
/// - Note: Protocol is just responsible for preparing the parameters within
/// - Remark: Passed by reference for URLRequest object!
protocol BNetParameterEncoder {
    static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws
}

struct FormBodyParameterEncoding: BNetParameterEncoder {
    /// Arranging the body parameters given URLRequest object for *x-www-form*
    ///
    /// - Parameters:
    ///   - urlRequest: Custom reference of URLRequest object
    ///   - parameters: Form body parameters in dictionary type
    ///
    /// - Throws: None
    ///
    /// - SeeAlso: BNetHelper+Dictionary.swift
    static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws {
        if !parameters.isEmpty {
            urlRequest.httpBody = parameters.asStringData
        }
    }
}

struct QueryParameterEncoding: BNetParameterEncoder {
    /// Encode the query parameters for the given URLRequest.
    ///
    /// - Parameters:
    ///   - urlRequest:
    ///   - parameters: Query Parameters as Dictionary
    /// - Throws: MissingURLError
    ///
    /// - Warning: resolvingAgainstBaseURL flag
    static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw BNetError.missingURLError
        }
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.queryItems = [URLQueryItem]()
            components.setQueryItems(from: parameters)
            urlRequest.url = components.url
        }
    }
}

struct JSONParameterEncoding: BNetParameterEncoder {
    /// Encode the parameters for the json request type
    ///
    /// - Parameters:
    ///   - urlRequest: Reference of the object
    ///   - parameters: List of key-value pairs
    /// - Throws: NetworkError.codingError
    static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        } catch {
            throw BNetError.codingError
        }
    }
}
