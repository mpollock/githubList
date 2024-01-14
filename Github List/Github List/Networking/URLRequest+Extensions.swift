//
//  URLRequest+Extensions.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

public extension URLRequest {

    init?(baseURL: String,
          path: String,
          httpMethod: HTTPMethod,
          parameters: JSONObject? = nil,
          headers: [HTTPHeader]? = nil,
          body: Data? = nil) {

        var url = URL(string: baseURL)
        url = path.isEmpty ? url : URL(string: baseURL)?.appendingPathComponent(path)
        guard
            let url = url,
            var urlComponents = URLComponents(url: url, parameters: parameters)
        else {
            return nil
        }

        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        guard let urlWithQuery = urlComponents.url else {
            return nil
        }

        self.init(url: urlWithQuery)
        self.httpMethod = httpMethod.rawValue
        allHTTPHeaderFields = headers?.toDictionary
        httpBody = body
    }

    init?(endpoint: Endpoint) {
        self.init(
            baseURL: endpoint.baseURL,
            path: endpoint.path,
            httpMethod: endpoint.method,
            parameters: endpoint.parameters,
            headers: endpoint.additionalHeaders,
            body: endpoint.body
        )
    }
}

public extension URLComponents {
    init?(url: URL, parameters: JSONObject?) {
        self.init(url: url, resolvingAgainstBaseURL: false)
        queryItems = URLQueryItem.queryItems(from: parameters)
    }
}

public extension URLQueryItem {
    static func queryItems(from dictionary: JSONObject?) -> [URLQueryItem]? {
        return dictionary?.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
    }
}
