//
//  BNetConstants.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation

//MARK:- Typealiases
/*
 * Dictionaries
 */
public typealias Parameters = [String: Any]
public typealias HTTPHeader = [String: String]
public typealias ParametersMap = Dictionary<String, Parameters>


/*
 * Clousures
 */
public typealias SuccessClousure = (Data) -> Void
public typealias FailureClousure = (Int, String) -> Void
public typealias RouterClousure = (Data?, URLResponse?, Error?) -> ()


//MARK:- HTTP Task
/// Task for the request
///
/// - request: Plain request without any parameter
/// - requestParams: Request with Json, Form or Query parameters
/// - requestParamsWithHeader: Request with both parameters and additional header
public enum HTTPTask {
    
    case request
    case requestParams(parameters: ParametersMap)
    case requestParamsWithHeader(parameters: ParametersMap, extraHeader: HTTPHeader?)
}

//MARK:- HTTP Methods
public enum HTTPMethods: String {
    
    case get    = "GET"
    case put    = "PUT"
    case post   = "POST"
    case delete = "DELETE"
    case patch  = "PATCH"
    case copy   = "COPY"
}

//MARK:- Environment
/// Using to determine the base url
public enum BNetEnvironment {
    
    case local
    case development
    case test
    case production
}

//MARK:-
public enum ParameterType: String {
    
    case json       = "jsonParam"
    case query      = "queryParam"
    case x_www_form = "formParam"
}

//MARK:- Response
/// All possible response types with its codes which annotated by enum
///
/// - 1xx: This class of status code indicates a provisional response, consisting only of the Status-Line and optional headers, and is terminated by an empty line. There are no required headers for this class of status code. Since HTTP/1.0 did not define any 1xx status codes, servers MUST NOT send a 1xx response to an HTTP/1.0 client except under experimental conditions.
///
///         A client MUST be prepared to accept one or more 1xx status responses prior to a regular response, even if the client does not expect a 100 (Continue) status message. Unexpected 1xx status responses MAY be ignored by a user agent.
///         Proxies MUST forward 1xx responses, unless the connection between the proxy and its client has been closed, or unless the proxy itself requested the generation of the 1xx response. (For example, if a proxy adds a "Expect: 100-continue" field when it forwards a request, then it need not forward the corresponding 100 (Continue) response(s).)
/// - 2xx: This class of status code indicates that the client's request was successfully received, understood, and accepted.
/// - 3xx: This class of status code indicates that further action needs to be taken by the user agent in order to fulfill the request. The action required MAY be carried out by the user agent without interaction with the user if and only if the method used in the second request is **GET** or **HEAD**. A client **SHOULD** detect infinite redirection loops, since such loops generate network traffic for each redirection.
/// - 4xx: The 4xx class of status code is intended for cases in which the client seems to have erred. Except when responding to a HEAD request, the server SHOULD include an entity containing an explanation of the error situation, and whether it is a temporary or permanent condition. These status codes are applicable to any request method. User agents SHOULD display any included entity to the user.
/// - 5xx: Response status codes beginning with the digit *5* indicate cases in which the server is aware that it has erred or is incapable of performing the request. Except when responding to a **HEAD** request, the server __SHOULD__ include an entity containing an explanation of the error situation, and whether it is a temporary or permanent condition. User agents __SHOULD__ display any included entity to the user. These response codes are applicable to any request method.
///
/// - Note: Previous versions of 3xx specification recommended a maximum of five redirections. Content developers should be aware that there might be clients that implement such a fixed limitation.
///
/// - See Also: [Messages](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)
public enum BNetResponse {
    
    // 1xx Information responses
    case Continue
    case switchingProtocol
    case processing
    case earlyHints
    
    // 2xx Successful responses
    case ok
    case created
    case accepted
    case noContent
    
    // 3xx Redirects
    case notModified
    
    // 4xx Client errors
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case conflict
    
    // 5xx Server errors
    case internalServerError
}

//MARK:- Result
public enum BNetResult<String> {
    
    case success(String)
    case failure(String)
    
    case redirection(String)
}

//MARK:- Response Messages
extension BNetResponse {
    
    /// User-friendly message based on the status code of response
    var message: String {
        switch self {
        case .Continue:
            return "Should continue the request, or ignore the response if the request is already finished."
        case .switchingProtocol:
            return "The server understands and is willing to comply with the client's request."
        case .processing:
            return "The server has received and is processing the request, but no response is available yet."
        case .earlyHints:
            return "Let the user agent start preloading resources while the server prepares a response."
        case .ok:
            return "The request has succeeded"
        case .created:
            return "The request has been fulfilled and resulted in a new resource being created"
        case .accepted:
            return "The request has been accepted for processing, but the processing has not been completed."
        case .noContent:
            return "The server has fulfilled the request but does not need to return an entity-body, and might want to return updated metainformation"
        case .notModified:
            return "The resource has not been modified since last requested"
        case .badRequest:
            return "The request could not be understood by the server due to malformed syntax"
        case .unauthorized:
            return "The request requires user authentication. The response MUST include a www-authenticate header field"
        case .forbidden:
            return "The server understood the request, but is refusing to fulfill it"
        case .notFound:
            return "The server has not found anything matching the Request-URI. No indication is given of whether the condition is temporary or permanent"
        case .conflict:
            return "The request could not be completed due to a conflict with the current state of the resource"
        case .internalServerError:
            return "The server encountered an unexpected condition which prevented it from fulfilling the request."
        }
    }
}
