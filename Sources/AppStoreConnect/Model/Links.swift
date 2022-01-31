//
//  Links.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public struct Links: Codable {
    let current: URL
    let first: URL?
    let next: URL?
    
    private enum CodingKeys: String, CodingKey {
        case current = "self"
        case first
        case next
    }
}
