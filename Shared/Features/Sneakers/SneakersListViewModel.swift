//
//  SneakersListViewModel.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import Foundation
import Combine

class SneakerListViewModel: ObservableObject {
    @Published var sneakers: [Sneaker] = []
    private var cancellationToken: AnyCancellable?
    init() {
        getSneakers()
    }
    
    func getSneakers() {
        cancellationToken = SneakersDB.request(.sneakers, type: SneakerResponse.self)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }) { value in
                self.sneakers = value.results
            }
    }
}
