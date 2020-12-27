//
//  SneakersDB.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

// Data From https://app.swaggerhub.com/apis-docs/tg4solutions/the-sneaker-database/1.0.0#/

enum SneakersDB {
    private static let apiClient = APIClient()
    private static let baseURL = URL(string: "https://api.thesneakerdatabase.com/")!
    static let allBrands: BrandRequest = BrandRequest(api: apiClient, baseURL: baseURL)
    static let allSneakers = SneakerRequest(api: apiClient, baseURL: baseURL)
}

protocol NetworkRequest {
    associatedtype Resource: Decodable
    var api: APIClient { get }
    var baseURL: URL { get }
    func request(base: URL) -> URLRequest
    func fetch() -> AnyPublisher<Resource, Error>
}

extension NetworkRequest {
    func fetch() -> AnyPublisher<Resource, Error> {
        return api.run(request(base: baseURL))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
 
struct BrandRequest: NetworkRequest {
    let api: APIClient
    let baseURL: URL
    func request(base: URL) -> URLRequest {
        let request = URLRequest(url: baseURL.appendingPathComponent("v1/brands"))
        return request
    }
    
    typealias Resource = BrandsResponse
}

struct SneakerRequest: NetworkRequest {
    let api: APIClient
    let baseURL: URL
    func request(base: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent("v1/sneakers"), resolvingAgainstBaseURL: true) else {
            fatalError()
        }
        components.queryItems = [URLQueryItem(name: "limit", value: "10")]
        
        return URLRequest(url: components.url!)
    }
    
    typealias Resource = SneakerResponse
}

