//
//  APIClient.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

struct APIClient {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    let decoder = JSONDecoder()
    let logging: Bool
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {        
        return URLSession.shared
                  .dataTaskPublisher(for: request)
                  .tryMap { result -> Response<T> in
                    if logging {
                        let response = String(data: result.data, encoding: .utf8)
                        print("Response: \(response)")
                    }
                    let value = try decoder.decode(T.self, from: result.data)                      
                    return Response(value: value, response: result.response)
                  }
                  .receive(on: DispatchQueue.main)
                  .eraseToAnyPublisher()
    }
}
