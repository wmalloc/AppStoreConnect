//
//  File.swift
//
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation
import os.log

extension Data {
    func validateNotEmpty() throws -> Self {
        guard !isEmpty else {
            throw URLError(.zeroByteResource)
        }
        return self
    }
    
    func validate(_ response: URLResponse, acceptableStatusCodes: Range<Int> = 200 ..< 300, acceptableContentTypes: Set<String>? = nil) throws -> Self {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard acceptableStatusCodes.contains(httpResponse.statusCode) else {
            let errorCode = URLError.Code(rawValue: httpResponse.statusCode)
            let errorString = String(data: self, encoding: .utf8)
            os_log(.error, "%@", errorString ?? "Unkown Error")
            throw URLError(errorCode)
        }
        
        if let validContentType = acceptableContentTypes {
            if let contentType = httpResponse.allHeaderFields[HTTPHeaderType.contentType] as? String {
                if !validContentType.contains(contentType) {
                    throw URLError(.dataNotAllowed)
                }
            } else {
                throw URLError(.badServerResponse)
            }
        }
        
        return self
    }
    
    static func validate(_ data: Data, _ response: URLResponse) throws -> Self {
        try data.validate(response).validateNotEmpty()
    }
}
