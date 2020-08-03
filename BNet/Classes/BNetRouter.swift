//
//  BNetRouter.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation

/**
 Routing protocol is managing and controlling the communication with remote.
 Based on the generic **Endpoint** protocol.
 
 ## Functions
 
 - request(Endpoint, RouterCompletion):
    * Endpoint object will be implemented by custom
    * RouterCompletion is a clousure that is defined in the NetworkConstant.swift as typealias
 - wait(): Suspend the URL task until resume again.
 - cancel(): Close the session thread, and shut down the communication,
 until the new task is created.
 
 ## Typealias ✨
 
 - Endpoint: Protocol instance to generalize the request method.
 
 ## Example ⚙️
 ```swift
 let loginEndpoint = AuthenticationEndpoint.login("foo@bar.com","123456")
 foo.request(loginEndpoint, completion: { (data, response, error) in
    // Operations..
 })
 ```
 */
public protocol BNetRouterProtocol {
    associatedtype EndPoint: BNetRequestProtocol
    // Functions
    func request<P:Codable>(_ route: EndPoint, decoded: P.Type, onSuccess: @escaping (P) -> Void, onFailure: @escaping (BNetError) -> Void)
    func wait()
    func cancel()
    // Variable
    var timeout: TimeInterval { get set }
}

// MARK: - Router Class
/// Router class
open class BNRouter<T: BNetRequestProtocol> : BNetRouterProtocol {

    // MARK: - Properties
    //
    // Note: If you want to change decoding format, access and set the decoder property.
    var sessionTask: URLSessionTask?
    public var decoder = JSONDecoder()
    public var timeout = TimeInterval(exactly: 25.0)!

    // MARK: - Protocol Methods
    public func request<P: Codable>(_ route: T, decoded: P.Type, onSuccess: @escaping (P) -> Void, onFailure: @escaping (BNetError) -> Void) {
        let session = URLSession.shared
        do {
            let urlReq = try buildRequest(route: route)
            sessionTask = session.dataTask(with: urlReq, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async { onFailure(BNetError.connectionFailed) }
                }
                if let httpResponse = response as? HTTPURLResponse {
                    //TODO: Transmit the server message to the user...!
                    let result =  self.handleNetworkResponse(httpResponse)
                    guard let responseData = data else {
                        DispatchQueue.main.async { onFailure(BNetError.noResponse) }
                        return
                    }
                    switch result {
                    case .success(_):
                        do {
                            let apiResponse = try self.decoder.decode(P.self, from: responseData)
                            
                            DispatchQueue.main.async { onSuccess(apiResponse) }
                        } catch {
                            DispatchQueue.main.async { onFailure(BNetError.codingError) }
                        }
                        break
                    case .redirection(let message), .failure(let message):
                        DispatchQueue.main.async { onFailure(BNetError.customError(id: 10, message: message)) }
                        break
                    }
                } else {
                    DispatchQueue.main.async { onFailure(BNetError.noResponse) }
                }
            })
        } catch let error as BNetError {
            DispatchQueue.main.async { onFailure(error) }
        } catch {
            DispatchQueue.main.async { onFailure(BNetError.codingError) }
        }
        sessionTask?.resume()
    }

    /// Wait session
    ///
    /// - TODO: Takes argument as Time(ms)
    public func wait() {
        guard let task = sessionTask else {
            return
        }
        task.suspend()
    }

    /// Cancel session
    public func cancel() {
        guard let task = sessionTask else {
            return
        }
        task.cancel()
    }
}

extension BNRouter {
    /// Request object which also contains the query and body parameters
    ///
    /// - Parameter route: Routing
    /// - Returns: URLRequest object
    /// - Throws: Encoding error
    private func buildRequest(route: EndPoint) throws -> URLRequest {
        guard let base = route.baseURL else {
            throw BNetError.missingURLError
        }
        let requestURL = base.appendingPathComponent(route.path)
        var request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeout)
        request.httpMethod = route.method.rawValue
        if let header = route.header {
            for (k,v) in header {
                request.addValue(v, forHTTPHeaderField: k)
            }
        }
        do {
            switch route.task {
            case .requestJSON(let body, let queryParams, let extraHeader):
                try JSONParameterEncoding.encode(urlRequest: &request, object: body)
                if let queryP = queryParams {
                    try QueryParameterEncoding.encode(urlRequest: &request, parameters: queryP)
                }
                if let additional = extraHeader {
                    for (k,v) in additional {
                        request.addValue(v, forHTTPHeaderField: k)
                    }
                }
                break
            case .request:
                // Plain request does nothing with parameters (given NULL)
                break
            case .requestParams(let parameters):
                try configureParameters(urlRequest: &request, parametersMap: parameters)
                break
            
            case .requestParamsWithHeader(let parameters, let extraHeader):
                try configureParameters(urlRequest: &request, parametersMap: parameters)
                if let additional = extraHeader {
                    for (k,v) in additional {
                        request.addValue(v, forHTTPHeaderField: k)
                    }
                }
                break
            }
            return request
        }
    }

    /// Generalize the parameters encoding function with given parameters
    ///
    /// - Parameters:
    ///   - urlRequest:
    ///   - jsonBody:
    ///   - formBody:
    ///   - queryParams:
    ///
    /// - Throws: Network Encoding Error
    private func configureParameters(urlRequest: inout URLRequest, parametersMap: ParametersMap) throws {
        do {
            let json = parametersMap[ParameterType.json.rawValue]
            let form = parametersMap[ParameterType.x_www_form.rawValue]
            let query = parametersMap[ParameterType.query.rawValue]
            
            if let body = form {
                try FormBodyParameterEncoding.encode(urlRequest: &urlRequest, parameters: body)
            }
            if let query = query {
                try QueryParameterEncoding.encode(urlRequest: &urlRequest, parameters: query)
            }
            if let json = json {
                try JSONParameterEncoding.encode(urlRequest: &urlRequest, parameters: json)
            }
        } catch {
            throw error
        }
    }

    /// Classify the response with respect to the its status code
    ///
    /// - Parameter response: Response returned from cloud
    /// - Returns: Network Result object
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> BNetResult<String> {
        switch response.statusCode {
        case 100:
            return .success(BNetResponse.continue_.message)
        case 101:
            return .success(BNetResponse.switchingProtocol.message)
        case 102:
            return .success(BNetResponse.processing.message)
        case 103:
            return .success(BNetResponse.earlyHints.message)
        case 200:
            return .success(BNetResponse.ok.message)
        case 201:
            return .success(BNetResponse.created.message)
        case 204:
            return .success(BNetResponse.noContent.message)
        case 304:
            return .redirection(BNetResponse.notModified.message)
        case 400:
            return .failure(BNetResponse.badRequest.message)
        case 401:
            return .failure(BNetResponse.unauthorized.message)
        case 403:
            return .failure(BNetResponse.forbidden.message)
        case 404:
            return .failure(BNetResponse.notFound.message)
        case 409:
            return .failure(BNetResponse.conflict.message)
        case 500:
            return .failure(BNetResponse.internalServerError.message)
        default:
            return .failure("Undefined response which the status code is \(response.statusCode)")
        }
    }
}
