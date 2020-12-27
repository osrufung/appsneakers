//
//  SneakersDB.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

// Data From https://app.swaggerhub.com/apis-docs/tg4solutions/the-sneaker-database/1.0.0#/
// API architure based on https://engineering.nodesagency.com/categories/ios/2020/03/16/Combine-networking-with-a-hint-of-swiftUI
//
enum SneakersDB {
    static let apiClient = APIClient()
    static let baseURL = URL(string: "https://api.thesneakerdatabase.com/")
}

enum ApiPath<T>: String {
    case brands = "v1/brands"
    case sneakers = "v1/sneakers"
        
}

extension SneakersDB {
    static func request<T: Decodable>(_ path: ApiPath<T>, type: T.Type) -> AnyPublisher<T, Error> {
        
        guard var components = URLComponents(url: baseURL!.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true) else {
            fatalError()
        }
        components.queryItems = [URLQueryItem(name: "limit", value: "10")]
        
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
