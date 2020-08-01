//
//  BNetManager.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation


/// Main module to sustain the request
public protocol BNetRequestProtocol {
    
    var task: HTTPTask { get }
    var baseURL: URL? { get }
    var path: String { get }
    var header: HTTPHeader? { get }
    var method: HTTPMethods { get }
}


/// Manage all network access, routing and coding of data
public class BNetManager {
    
    public static let shared = BNetManager()
    
    private var token: String?
    public static var environment = BNetEnvironment.development       // default is dev
    
    
    /// Setter for private variable
    /// - Parameter token: Authorization token
    public func setToken(_ token: String) {
        self.token = token
    }
    
    /// Getter for private variable
    public func getToken() -> String {
        if let token = self.token {
            return token
        }
        
        return ""
    }
    
    
    /// Generic function is necessary to specify the router
    ///
    /// - Parameter endpointType: Endpoint type
    /// - Returns: BNRouter object
    ///
    /// - Note: The router must be specified before create a request, i.e
    ///
    ///  ~~~~swift
    ///  let router = BNetManager.shared.accessRouter(UsersEndpoint.self)
    ///  router.request(.connections, decoded: ConnectionResponse.self, onSuccess: {(res) in
    ///     // Success scope
    ///  }, onFailure: {(err) in
    ///     // Failure scope
    ///  })
    ///  ~~~~
    public func accessRouter<T: BNetRequestProtocol>(endpointType: T.Type) -> BNRouter<T> {
        let router = BNRouter<T>()
        return router
    }
    
}
