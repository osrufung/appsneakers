//
//  SneakersListViewModel.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine
class SneakerListViewModel: ObservableObject {
    enum State {
        case idle
        case loading
        case failed(Error)
        case loaded([Sneaker])
    }
   
    @Published private(set) var state = State.idle
    
    private var cancellationToken: AnyCancellable?
    let brand: String
    
    init(brand: String) {
        self.brand = brand
    }
    
    func getSneakers() {
        state = .loading        
        cancellationToken = SneakersDB.sneakers(for: brand).fetch()
            .mapError({ (error) -> Error in                
                return error
            })
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.state = .failed(error)
                }
            }) { value in
                self.state = .loaded(value.results)
            }
    }
}
