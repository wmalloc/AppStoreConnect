//
//  ErrorResponse.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public struct ErrorResponse: Codable {
    public var errors: [Error]
    
    public struct Error: Codable {
        public var id: String
        public var status: String
        public var code: String
        public var title: String
        public var detail: String
    }
}
