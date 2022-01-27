//
//  AgeRatingDeclarationResponse.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public struct AgeRatingDeclarationResponse: Codable {
    public struct Data: Codable {
        public let type: String
        public let id: String
        public let attributes: AgeRatingDeclarationAttributes
        public let links: Links
    }
    
    public let data: Data
    public let links: Links
}
