//
//  RequestRouter.swift
//  GBShop
//
//  Created by Мария Коханчик on 14.08.2021.
//

import Foundation
import Alamofire

/// Реализация запросов к серверу.

enum RequestRouterEncodding {
    
    case url, json
}

protocol RequestRouter: URLRequestConvertible {
    
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var fullUrl: URL { get }
    var encoding: RequestRouterEncodding { get }

}

extension RequestRouter {
    
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    var encoding: RequestRouterEncodding {
        return .url
    }
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }

}
