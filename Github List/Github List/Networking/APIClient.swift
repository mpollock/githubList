//
//  APIClient.swift
//  Github List
//
//  Created by Michael on 1/13/24.
//

import Foundation

class APIClient: NSObject, URLSessionDelegate {
    static let shared = APIClient()
    private var urlSession = URLSession(configuration: .default)

    func requestData<T>(for urlRequest: URLRequest) async throws -> T where T: Codable {

        setConfiguration(request: urlRequest)

        return try await Task {
            let (data, response) = try await self.urlSession.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidData
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 401 {
                    throw NetworkError.unauthorized
                } else {
                    throw NetworkError.requestFailed
                }
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let jsonResponse = try decoder.decode(T.self, from: data)
                return jsonResponse
            } catch {
                throw NetworkError.invalidResponse
            }
        }
        .value
    }

    func setConfiguration(request: URLRequest) {
        urlSession.configuration.httpAdditionalHeaders = request.allHTTPHeaderFields
        urlSession.configuration.requestCachePolicy = request.cachePolicy
    }
}

public enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case invalidData
    case requestFailed
    case unauthorized
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidRequest:
            return "Invalid Request"
        case .invalidResponse:
            return "Invalid Response"
        case .invalidData:
            return "Invalid Data"
        case .requestFailed:
            return "Request Failed"
        case .unauthorized:
            return "Unauthorized"
        }
    }
}
