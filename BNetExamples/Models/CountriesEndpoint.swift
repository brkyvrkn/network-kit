//
//  CountriesEndpoint.swift
//  CoreNetworkingExample
//
//  Created by Berkay Vurkan on 14.10.2019
//  Copyright © 2019 Foo. All rights reserved.
//

import Foundation
import BNet

enum CountriesEndpoint<T: Codable> {
    case listAll
}

extension CountriesEndpoint: BNetRequestProtocol {

    var task: HTTPTask<T> {
        let apiKeyArg = ("apiKey", CurrencyConverterConstants.apiKey.rawValue)
        let params = Parameters(dictionaryLiteral: apiKeyArg)

        switch self {
        case .listAll:
            let parameters = ParametersMap(dictionaryLiteral: (ParameterType.query.rawValue, params))
            return .requestParams(parameters: parameters)
        }
    }

    var baseURL: URL? {
        switch BNetManager.environment {
        case .development:
            return URL(string: CurrencyConverterConstants.baseFreeUrl.rawValue)
        default:
            return nil
        }
    }

    var path: String {
        switch self {
        case .listAll:
            return CurrencyConverterConstants.apiVersion.rawValue + "/" + ServicePaths.countries.rawValue
        }
    }

    var header: HTTPHeader? {
        return nil
    }

    var method: HTTPMethods {
        return .get
    }
}
