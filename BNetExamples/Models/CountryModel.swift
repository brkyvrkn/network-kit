//
//  CountryModel.swift
//  CoreNetworkingExample
//
//  Created by Berkay Vurkan on 14.10.2019
//  Copyright © 2019 Foo. All rights reserved.
//

import Foundation

struct CountryModel: Codable {

    //MARK:- Attributes
    var id: String
    var name: String
    var alpha3: String
    var currency: CurrencyModel

    init(response: CountryResponseModel) {
        self.id = response.id
        self.name = response.name
        self.alpha3 = response.alpha3
        self.currency = CurrencyModel(id: response.currencyId,
                                      name: response.currencyName,
                                      symbol: response.currencySymbol ?? "")
    }
}
