//
//  BNetErrors.swift
//  BNetworking
//
//  Created by Berkay Vurkan on 11.10.2019
//  Copyright © 2019 Temp. All rights reserved.
//

import Foundation


//MARK:- Error Types
public enum BNetError: Error {
    
    case environmentError
    case codingError
    case missingURLError
    case missingParametersError
    case connectionFailed
    case noResponse
    
    case responseError(responseType: BNetResponse)
    case customError(id: Int, message: String)
}


//MARK:- Error messages
extension BNetError {
    
    /// User-friendly description of the errors
    public var description: String {
        switch self {
        case .environmentError:
            return "Could not access to the given environment."
        case .missingParametersError:
            return "Some of the required parameters are not given."
        case .codingError:
            return "Unsuccessful parsing between the given model and type."
        case .missingURLError:
            return "URL is not defined."
        case .responseError(let responseType):
            return responseType.message
        case .connectionFailed:
            return "Check your network connection."
        case .customError(_, let message):
            return message
        case .noResponse:
            return "Response could not retrieved."
        }
    }
}
