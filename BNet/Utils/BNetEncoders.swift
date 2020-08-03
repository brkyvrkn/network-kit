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
public protocol BNetParameterEncoder {
    static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws
}

public struct FormBodyParameterEncoding: BNetParameterEncoder {
    /// Arranging the body parameters given URLRequest object for *x-www-form*
    ///
    /// - Parameters:
    ///   - urlRequest: Custom reference of URLRequest object
    ///   - parameters: Form body parameters in dictionary type
    ///
    /// - Throws: None
    ///
    /// - SeeAlso: BNetHelper+Dictionary.swift
    public static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws {
        if !parameters.isEmpty {
            urlRequest.httpBody = parameters.asStringData
        }
    }
}

public struct QueryParameterEncoding: BNetParameterEncoder {
    /// Encode the query parameters for the given URLRequest.
    ///
    /// - Parameters:
    ///   - urlRequest:
    ///   - parameters: Query Parameters as Dictionary
    /// - Throws: MissingURLError
    ///
    /// - Warning: resolvingAgainstBaseURL flag
    public static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw BNetError.missingURLError
        }
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            if let params = parameters as? [String: String] {
                components.queryItems = [URLQueryItem]()
                components.setQueryItems(from: params)
                urlRequest.url = components.url
            } else {
                throw BNetError.customError(id: 403, message: "Query parameter values must be String type")
            }
        }
    }
}

public struct JSONParameterEncoding: BNetParameterEncoder {
    /// Encode the parameters for the json request type
    ///
    /// - Parameters:
    ///   - urlRequest: Reference of the object
    ///   - parameters: List of key-value pairs
    /// - Throws: NetworkError.codingError
    public static func encode(urlRequest: inout URLRequest, parameters: Parameters) throws {
        do {
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        }
    }
    public static func encode<T: Codable>(urlRequest: inout URLRequest, object: T) throws {
        do {
            let jsonData = try JSONEncoder().encode(object)
            urlRequest.httpBody = jsonData
        }
    }
}
