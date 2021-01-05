//
//  SneakerResponse.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation

protocol Convertible {
    associatedtype Destination: Decodable
    var translated: Destination? { get }
}

struct Safe<Base, Fallback: Convertible&Decodable>: Decodable where Fallback.Destination == Base {
    let value: Base?
    
    init(from decoder: Decoder)  {
        let container = try? decoder.singleValueContainer()
        if let base = try? container?.decode(Base.self) {
            value = base
        } else if let fallback = try? container?.decode(Fallback.self), let converted = fallback.translated {
            value = converted
        } else {
            value = nil
        }
        
    }
}

extension String: Convertible {
    var translated: Int? {
        return Int(self)
    }
}

struct SneakerResponse: Decodable {
    let count: Int
    let results: [Sneaker]
}

struct Sneaker: Decodable, Identifiable {
    var id: String { sku }
    let sku: String
    let brand: String
    let name: String
    let story: String?
    let releaseYear: Int
    let imgUrl: String
    let retailPrice: Safe<Int,String>?
    var priceFormatted: String {
        guard let price = retailPrice?.value else { return "" }
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
                                retailPrice: nil)
}
