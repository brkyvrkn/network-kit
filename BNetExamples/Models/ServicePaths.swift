//
//  ServicePaths.swift
//  CoreNetworkingExample
//
//  Created by Berkay Vurkan on 14.10.2019
//  Copyright © 2019 Foo. All rights reserved.
//

import Foundation

enum ServicePaths: String {
    case countries
    case currencies
    case usage
    case convert
}

enum CurrencyConverterConstants: String {
    case baseFreeUrl    = "https://free.currconv.com"
    case apiVersion     = "api/v7"
    case apiKey         = "67b79daab7f4e57332f8"
}
