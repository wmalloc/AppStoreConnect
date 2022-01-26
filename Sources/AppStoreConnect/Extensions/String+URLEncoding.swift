//
//  String+URLEncoding.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var queryParameterEscaped: String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }

    var utf8EncodedData: Data {
        data(using: .utf8)!
    }
}
