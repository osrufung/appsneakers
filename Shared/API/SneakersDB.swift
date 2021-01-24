//
//  SneakersDB.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

// Data From https://app.swaggerhub.com/apis-docs/tg4solutions/the-sneaker-database/1.0.0#/

struct DecodingError: Error {}

enum SneakersDB {
        
    private static let apiClient: APIClient = {
        let api = APIClient(logging: true)
        api.decoder.dateDecodingStrategy = .iso8601(extended: true)
        return api
    }()
    
    private static let apiConfig: APIConfig = APIConfig(apiClient: apiClient,
                                                        baseURL: URL(string: "https://api.thesneakerdatabase.dev/")!)
    static let allBrands = BrandRequest(config: apiConfig)
    static let allSneakers = SneakerRequest(config: apiConfig, brand: nil)
    static func sneakers(for brand: String) -> SneakerRequest {
        return SneakerRequest(config: apiConfig, brand: brand)
    }
}

struct APIConfig {
    let apiClient: APIClient
    let baseURL: URL
}

protocol NetworkRequest {
    associatedtype Resource: Decodable
    var config: APIConfig { get }
    func request(base: URL) -> URLRequest
    func fetch() -> AnyPublisher<Resource, Error>
}

extension NetworkRequest {
    func fetch() -> AnyPublisher<Resource, Error> {
        return config.apiClient.run(request(base: config.baseURL))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
 
struct BrandRequest: NetworkRequest {
    let config: APIConfig
    func request(base: URL) -> URLRequest {
        let request = URLRequest(url: config.baseURL.appendingPathComponent("v2/brands"))
        return request
    }
    
    typealias Resource = BrandsResponse
}

struct SneakerRequest: NetworkRequest {
    let config: APIConfig
    let brand: String?
    func request(base: URL) -> URLRequest {
        guard var components = URLComponents(url: config.baseURL.appendingPathComponent("v2/sneakers"), resolvingAgainstBaseURL: true) else {
            fatalError()
        }
        components.queryItems = [URLQueryItem(name: "limit", value: "20")]
        if let brand = brand {
            components.queryItems?.append(URLQueryItem(name: "brand", value: brand))
        }
        return URLRequest(url: components.url!)
    }
    
    typealias Resource = SneakerResponse
}


