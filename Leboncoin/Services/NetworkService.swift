//
//  NetworkService.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 13/02/2023.
//

import Foundation
import Combine

// MARK: - NetworkService

protocol NetworkServiceProtocol: AnyObject {
    typealias Headers = [String: Any]
    
    func get<T>(
        type: T.Type,
        url: URL,
        headers: Headers
    ) -> AnyPublisher<T, Error> where T: Decodable
}

final class NetworkService: NetworkServiceProtocol {
    
    func get<T: Decodable>(
        type: T.Type,
        url: URL,
        headers: Headers
    ) -> AnyPublisher<T, Error> {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Endpoint

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

/// API specific Endpoint extension
extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "raw.githubusercontent.com"
        components.path = "/leboncoin/paperclip/master/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return [:]
    }
}

/// API Endpoints
extension Endpoint {
    static var announcements: Self {
        return Endpoint(path: "/listing.json")
    }
    
    static var categories: Self {
        return Endpoint(path: "/categories.json")
    }
}
