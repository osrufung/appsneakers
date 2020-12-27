//
//  SneakerResponse.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation

struct SneakerResponse: Codable {
    let count: Int
    let results: [Sneaker]
}

struct Sneaker: Codable, Identifiable {
    struct Media: Codable {
        let thumbUrl: String?
    }
    let id: UUID
    let brand: String
    let shoe: String
    let year: Int
    let media: Media
    
}
