//
//  BrandsListViewModel.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

class BrandsListViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([String])
    }
  
    @Published private(set) var state = State.idle
    private var cancellationToken: AnyCancellable?

    func getBrands() {
        self.state = .loading
        self.cancellationToken = SneakersDB.allBrands.fetch()
            .mapError({ (error) -> Error in                
                return error
            })
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.state = .failed(error)
                }
            }) { value in
                self.state = .loaded(value.results.sorted())
            }            
    }
}
