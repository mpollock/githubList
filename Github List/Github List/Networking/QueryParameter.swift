//
//  QueryParameters.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

public protocol QueryParameterizable {
    var key: String { get }
    var value: String { get }
}

public struct QueryParameter: QueryParameterizable {
    public let key: String
    public let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

public extension Array where Element == QueryParameterizable {
    var toDictionary: JSONObject {
        return reduce(into: JSONObject()) { dict, param in
            dict[param.key] = param.value
        }
    }
}
