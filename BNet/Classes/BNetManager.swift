//
//  BNetManager.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//
// swiftlint:disable type_name

import Foundation

/// Main module to sustain the request
public protocol BNetRequestProtocol {
    associatedtype T: Codable
    var task: HTTPTask<T> { get }
    var baseURL: URL? { get }
    var path: String { get }
    var header: HTTPHeader? { get }
    var method: HTTPMethods { get }
}

public struct BNetConfig: Codable {
    var env: String
    var baseURL: String

    init(baseURL: String, env: String) {
        self.env = env
        self.baseURL = baseURL
    }
}

/// Manage all network access, routing and coding of data
open class BNetManager {

    // Shared instance
    public static let shared = BNetManager()
    // Attributes
    private var authToken: String?
    private var environment = BNetEnvironment.development(text: "dev")
    private var config_: BNetConfig

    private init() {
        self.authToken = nil
        self.config_ = BNetConfig(baseURL: "", env: self.environment.value)
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
    open func accessRouter<T: BNetRequestProtocol>(endpointType: T.Type) -> BNRouter<T> {
        let router = BNRouter<T>()
        return router
    }
}

// MARK: - Accessors
extension BNetManager {

    public var token: String? {
        get {
            return self.authToken
        } set {
            self.authToken = newValue
        }
    }

    public var env: BNetEnvironment {
        get {
            return self.environment
        } set {
            self.environment = newValue
        }
    }

    public var configurations: BNetConfig {
        get {
            return self.config_
        }
    }
}
