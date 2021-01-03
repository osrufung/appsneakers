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

struct Sneaker: Codable, Hashable {
    let sku: String
    let brand: String
    let name: String
    let story: String?
    let releaseYear: Int
    let imgUrl: String
    let retailPrice: Int?
    var priceFormatted: String {
        guard let price = retailPrice else { return "" }
        return "$ \(price)"
    }
}

extension Sneaker {
    static let sample = Sneaker(sku: "DJ0675-200",
                                brand: "Nike",
                                name: "Nike Dunk",
                                story: "Nike Dunk High Sail Football Grey",
                                releaseYear: 2001,
                                imgUrl: "https://stockx.imgix.net/images/Nike-Dunk-High-Sail-Football-Grey-W.png?fit=fill&bg=FFFFFF&w=140&h=100&auto=format,compress&trim=color&q=90&dpr=2&updated_at=1609367425",
                                retailPrice: 102)
}
