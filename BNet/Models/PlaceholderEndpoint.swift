//
//  PlaceholderEndpoint.swift
//  BNet
//
//  Created by Berkay Vurkan on 3.08.2020.
//  Copyright © 2020 Foo. All rights reserved.
//

import Foundation

/// Object model in order to test the interface
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    /// Custom coding keys to associate variable with its key value
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }

    /// Initializer for the Post model
    /// - Parameters:
    ///   - userID: Any int value
    ///   - id: Any int value
    ///   - title: Any string value
    ///   - body: Any string value
    init(userID: Int, id: Int, title: String, body: String) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
    }
}

/// Endpoint interface to test the client
enum PlaceholderEndpoint<T: Codable> {
    case jsonPlaceholder
    case missUrl
}

extension PlaceholderEndpoint: BNetRequestProtocol {

    var task: HTTPTask<T> {
        return .request
    }

    var baseURL: URL? {
        switch self {
        case .jsonPlaceholder:
            return URL(string: "https://jsonplaceholder.typicode.com")
        default:
            return nil
        }
    }

    var path: String {
        return "posts"
    }

    var header: HTTPHeader? {
        return HTTPHeader(dictionaryLiteral: (HTTPHeaderKeys.MessageBodyInformation.content_type.rawValue,
                                              HTTPHeaderValues.ContentType.application(subtype: "json").value))
    }

    var method: HTTPMethods {
        return .get
    }
}
