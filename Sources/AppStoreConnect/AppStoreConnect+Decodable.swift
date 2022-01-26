//
//  File.swift
//  
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

@available(swift 5.5)
@available(iOS 13, tvOS 13, watchOS 7, macOS 10.15, macCatalyst 13, *)
public extension AppStoreConnect {
    func decodable<T: Decodable>(service: URLRequestable, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let request = try service.urlRequest()
        return try await decodable(request: request, decoder: decoder)
      }

      func decodable<T: Decodable>(request: URLRequest, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let (data, _) = try await data(request: request)
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
      }

      func serializable(service: URLRequestable, options: JSONSerialization.ReadingOptions = .allowFragments) async throws -> Any {
        let request = try service.urlRequest()
        return try await serializable(request: request, options: options)
      }

      func serializable(request: URLRequest, options: JSONSerialization.ReadingOptions = .allowFragments) async throws -> Any {
        let (data, _) = try await data(request: request)
        let decoded = try JSONSerialization.jsonObject(with: data, options: options)
        return decoded
      }

      func data(service: URLRequestable) async throws -> (Data, HTTPURLResponse) {
        let request = try service.urlRequest()
        return try await data(request: request)
      }

      func data(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let result: (data: Data, response: URLResponse)
        if #available(iOS 15, tvOS 15, watchOS 8, macCatalyst 15, macOS 12, *) {
          result = try await session.data(for: request, delegate: nil)
        } else {
          result = try await session.data(for: request)
        }

        let validData = try result.data.validate(result.response).validateNotEmpty()
        guard let httpURLResponse = result.response as? HTTPURLResponse else {
          throw URLError(.badServerResponse)
        }
        return (validData, httpURLResponse)
      }
}
