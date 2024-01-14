//
//  RequestBuilder.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

public typealias JSONObject = [String: Any]

public struct Endpoint {
    let path: String
    let method: HTTPMethod
    var parameters: JSONObject?
    var queryParameters: [QueryParameterizable]?
    let body: Data?
    let baseURL: String
    let additionalHeaders: [HTTPHeader]
    let useMock: Bool

    init (
        path: String = "",
        method: HTTPMethod,
        queryParameters: [String: String]? = nil,
        body: Data? = nil,
        baseURL: String = "https://api.github.com", // TODO: put this in a config
        additionalHeaders: [HTTPHeader] = [.authorization(.bearer(token: "fakeToken"))],
        useMock: Bool = false
    ) {
        self.path = path
        self.method = method
        // TODO: Clean this query params nonsense up
        self.queryParameters = queryParameters?.map {key, value in
            return QueryParameter(key: key, value: value)
        } ?? []
        self.parameters = self.queryParameters?.toDictionary
        self.body = body
        self.baseURL = baseURL
        self.additionalHeaders = additionalHeaders
        self.useMock = useMock
    }
}

public enum HTTPHeader {
    public enum Authentication {
        case bearer(token: String)
    }

    case authorization(Authentication)

    public var key: String {
        switch self {
        case .authorization:
            return "Authorization"
        }
    }

    public var value: String {
        switch self {
        case .authorization(let type):
            switch type {
            case .bearer(let token):
                return "Bearer \(token)"
            }
        }
    }
}

public extension Array where Element == HTTPHeader {
    var toDictionary: [String: String] {
        return reduce(into: [String: String]()) { dict, header in
            dict[header.key] = header.value
        }
    }
}

extension Endpoint {
    static func encoded(_ parameters: [String: String]) -> Data? {
        let string = parameters.map { (key, value) -> String in
            "\(key)=\(value)"
        }.joined(separator: "&")
        return string.data(using: .utf8)
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}
