//
//  BNetHeaderValues+ContentType.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 15.10.2019.
//

import Foundation

extension HTTPHeaderValues.ContentType {

    /// Generic value format which was concatenated with given subtype
    public var value: String {
        switch self {
        case .application(let subtype):
            return "application/\(subtype);"
        case .audio(let subtype):
            return "audio/\(subtype);"
        case .image(let subtype):
            return "image/\(subtype);"
        case .multipart(let subtype):
            return "multipart/\(subtype);"
        case .text(let subtype):
            return "text/\(subtype);"
        case .video(let subtype):
            return "video/\(subtype);"
        }
    }

    /// Content Type Value with appended parameter
    ///
    /// Parameters are modifiers of the content-subtype, and do not fundamentally affect the requirements of the host system. Although most parameters make sense only with certain content-types, others are *global* in the sense that they might apply to any subtype. For example, the "boundary" parameter makes sense only for the *multipart* content-type, but the *charset* parameter might make sense with several content-types.
    ///
    /// - Parameter with: Key-Value pair of parameter to be appended
    public func parametrizedValue(with: (String, String)) -> String {
        return value + with.0 + "=" + with.1
    }
}
