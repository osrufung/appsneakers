//
//  SneakersDB.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

enum SneakersDB {
    static let apiClient = APIClient()
    static let baseURL = URL(string: "https://api.thesneakerdatabase.com/")
}

enum ApiPath: String {
    case brands = "v1/brands"
}

extension SneakersDB {
    static func request(_ path: ApiPath) -> AnyPublisher<BrandsResponse, Error> {
        guard let url = baseURL?.appendingPathComponent(path.rawValue) else {
            fatalError()
        }
        
        let request = URLRequest(url: url)
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
