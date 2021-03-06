//
//  URLSession+Concurrency.swift
//
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public extension URLSession {
    class var defaultClientSession: URLSession {
        let configuration = URLSessionConfiguration.default
        let headers = [HTTPHeaderType.acceptLanguage: "en;q=1.0", HTTPHeaderType.acceptEncoding: "br;q=1.0, gzip;q=0.9, deflate;q=0.8"]
        configuration.httpAdditionalHeaders = headers
        return URLSession(configuration: configuration)
    }
}

@available(swift 5.5)
@available(iOS, introduced: 13.0, deprecated: 15.0, message: "Use the built-in API instead")
@available(tvOS, introduced: 13.0, deprecated: 15.0, message: "Use the built-in API instead")
@available(watchOS, introduced: 6.0, deprecated: 8.0, message: "Use the built-in API instead")
@available(macCatalyst, introduced: 13.0, deprecated: 15.0, message: "Use the built-in API instead")
@available(macOS, introduced: 10.15, deprecated: 12.0, message: "Use the built-in API instead")
public extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}
