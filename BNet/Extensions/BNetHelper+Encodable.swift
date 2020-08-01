//
//  BNetHelper+Encodable.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation

extension Encodable {

    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let dict = json.flatMap {
            $0 as? [String: Any]
        }
        return dict
    }
}
