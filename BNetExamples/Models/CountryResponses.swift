//
//  CountryResponses.swift
//  CoreNetworkingExample
//
//  Created by Berkay Vurkan on 14.10.2019
//  Copyright © 2019 Foo. All rights reserved.
//

import Foundation

struct CountryResponseModel: Codable {
    var id: String
    var name: String
    var alpha3: String
    var currencyId: String
    var currencyName: String
    var currencySymbol: String?
}

struct CountryListResponseModel: Codable {    
    var results: [String: CountryResponseModel]
}
