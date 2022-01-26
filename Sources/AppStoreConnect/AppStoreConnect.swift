//
//  AppStoreConnect.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 01/26/22.
//

import Foundation

public class AppStoreConnect {
    public let errorDomain = Bundle(for: AppStoreConnect.self).bundleIdentifier! + ".Error"
    public let validStatusCodes: Range<Int> = 200 ..< 300
    
    public let session: URLSession

    public init(session: URLSession = .defaultClientSession) {
      self.session = session
    }
}
