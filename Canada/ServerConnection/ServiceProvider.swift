//
//  ServiceProvider.swift
 
 

import Foundation
import Security
 

let appTimeoutInterval = TimeInterval(30)

enum ServiceError {
    case InvalidRequest
    case DecodeError(decodeError:String)
    case InvalidResponse(invalidResponse:String)
    case UnknownError
    
    func getMessage() -> String {
        switch self{
        case .InvalidResponse (let message):
            return message
        case .DecodeError (let message):
            return message
        case .InvalidRequest:
            return "Invalid Request" //TODO: Add localizes string for this string value
        case .UnknownError:
            return "Unknown Error" //TODO: Add localizes string for this string value
        }
    }
}

typealias ServiceCallback = (_ success:Bool,_ data:Any?,_ error:ServiceError?) -> Void
typealias ViewModelCallback = (_ success:Bool,_ error:String?) -> Void



 
