//
//  BNetEnvironment+Values.swift
//  BNet
//
//  Created by Berkay Vurkan on 2.08.2020.
//  Copyright © 2020 Foo. All rights reserved.
//

import Foundation

extension BNetEnvironment {
    public var value: String {
        get {
            switch self {
            case .development(let text):
                return "\(text)"
            case .local(let text):
                return "\(text)"
            case .production(let text):
                return "\(text)"
            case .test(let text):
                return "\(text)"
            }
        }
    }
}
