//
//  SneakerResponse.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import SafeCodable

struct SneakerResponse: Decodable {
    let count: Int
    let results: [Sneaker]
}

struct Sneaker: Decodable, Identifiable, Equatable {
    static func == (lhs: Sneaker, rhs: Sneaker) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String { sku }
    let sku: String
    let brand: String
    let name: String
    let gender: String
    let colorway: String
    let story: String?
    let releaseYear: Int
    let releaseDate: Date?
    let imgUrl: String
    let retailPrice: Safe<Int,String>?
    let links: String?
    
}

extension Sneaker {
    struct Shop: Hashable {
        let name: String
        let link: URL
    }
    static var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter
    }
    
    var dateFormatted: String? {
        guard let date = releaseDate else { return nil }
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var priceFormatted: String {
        guard let price = retailPrice?.value else { return "" }        
        return Sneaker.numberFormatter.string(from: NSNumber(integerLiteral: price)) ?? ""
    }
    
    var buyLinks: [Shop] {
        guard let links = links?
                .trimmingCharacters(in: .init(charactersIn: "[]"))
                .split(separator: ",") else { return [] }
        
        let shops: [Shop] = links.compactMap { item in
            guard let url = URL(string: item.trimmingCharacters(in: .whitespaces)) else { return nil }
            return Shop(name: url.host ?? "Unknown", link: url)
        }
            
        return shops
    }
}


extension Sneaker {
    static let sample: Sneaker = {
        let decoder = JSONDecoder()
        let path = Bundle.main.path(forResource: "sneakers", ofType: "json")!
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        let response = try? decoder.decode(SneakerResponse.self, from: data!)
        return (response?.results.first)!
    }()

}
