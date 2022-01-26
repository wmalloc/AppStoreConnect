//
//  Routable.swift
//  AppStoreConnect
//
//  Created by Waqar Malik on 1/26/22.
//

import Foundation

public protocol URLRequestable {
    static var userAgent: String? { get set }
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var httpShouldHandleCookies: Bool { get }

    func url() throws -> URL
    func urlRequest() throws -> URLRequest
}

public extension URLRequestable {
    var defaultHeaders: [String: String]? {
        nil
    }

    var httpShouldHandleCookies: Bool {
        true
    }

    var parameters: [String: Any] {
        [:]
    }

    var queryItems: [URLQueryItem]? {
        guard httpMethod == .get, !parameters.isEmpty else {
            return nil
        }

        let converted: [String: String] = parameters.compactMapValues { anyValue in
            if let boolValue = anyValue as? Bool {
                return String(boolValue)
            } else if let intValue = anyValue as? Int {
                return String(intValue)
            } else if let stringValue = anyValue as? String {
                return stringValue.queryParameterEscaped
            } else {
                return ""
            }
        }

        return converted.compactMap { item -> URLQueryItem? in
            URLQueryItem(name: item.key, value: item.value)
        }
    }

    var body: Data? {
        guard httpMethod == .post || httpMethod == .put else {
            return nil
        }

        guard !parameters.isEmpty else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: parameters, options: .withoutEscapingSlashes)
    }

    func url() throws -> URL {
        guard let baseURL = baseURL else {
            throw URLError(.badURL)
        }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.path = path
        if let queryItems = queryItems {
            components?.queryItems = queryItems
        }
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        return url
    }

    func urlRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpShouldHandleCookies = httpShouldHandleCookies
        headers?.forEach { item in
            urlRequest.setValue(item.value, forHTTPHeaderField: item.key)
        }
        urlRequest.httpBody = body
        return urlRequest
    }
}
