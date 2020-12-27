//
//  BrandsListViewModel.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

class BrandsListViewModel: ObservableObject {
    @Published var brands: [String] = []
    var cancellationToken: AnyCancellable?
    init() {
        getBrands()
    }
    func getBrands() {
        self.cancellationToken = SneakersDB.request(.brands)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }) { value in
                self.brands = value.results
            }            
    }
}
