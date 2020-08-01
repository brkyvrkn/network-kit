//
//  CurrencyResponses.swift
//  CoreNetworkingExample
//
//  Created by Berkay Vurkan on 14.10.2019
//  Copyright © 2019 Foo. All rights reserved.
//

import Foundation

struct CurrencyResponseModel: Codable {
    var id: String
    var currencyName: String
    var currencySymbol: String?
}

struct CurrencyListResponseModel: Codable {
    var results: [CurrencyResponseModel]
}
