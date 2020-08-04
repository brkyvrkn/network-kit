//
//  BNetHelper+Dictionary.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation

extension Dictionary {

    var asStringParams: String {
        get {
            return customDescription()
        }
    }

    var asStringData: Data? {
        get {
            return self.asStringParams.data(using: .utf8)
        }
    }

    private func customDescription() -> String {
        var str = self.reduce("") {
            return $0 + "\($1.key)=\($1.value)&"
        }
        if !str.isEmpty {
            str.removeLast()
        }
        return str
    }
}
