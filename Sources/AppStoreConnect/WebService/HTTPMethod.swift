//
//  HTTPMethod.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public enum HTTPMethod: String, CaseIterable, Hashable {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

    public var shouldEncodeParametersInURL: Bool {
        switch self {
        case .get, .head, .delete:
            return true
        default:
            return false
        }
    }
}
