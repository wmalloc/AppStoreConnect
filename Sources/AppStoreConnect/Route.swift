//
//  Route.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation


public enum Route: URLRequestable {
    static let baseURLString = "https://api.appstoreconnect.apple.com"

    case ageRatingDeclarations(String, AgeRatingDeclarationAttributes) // AgeRatingDeclaration
    
    public static var userAgent: String?
    
    public var baseURL: URL? {
        URL(string: Self.baseURLString)
    }
    
    public var path: String {
        let version = "/v1"
        switch self {
        case .ageRatingDeclarations(let id, _):
            return version + "/ageRatingDeclarations/" + id
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .ageRatingDeclarations:
            return .patch
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var body: Data? {
        var body: [String: Any] = [:]
        switch self {
        case .ageRatingDeclarations(let id, let attributes):
            body["type"] = "ageRatingDeclarations"
            body["id"] = id
            body["attributes"] = attributes
        }
        
        return body.isEmpty ? nil : try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    }
}
