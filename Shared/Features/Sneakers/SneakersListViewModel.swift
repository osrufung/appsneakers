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
        case loadingMorePages([Sneaker])
    }
   
    @Published private(set) var state = State.idle
    
    private var cancellationToken: AnyCancellable?
    private var total: Int = 0
    private var currentPage: Int = 0
    let brand: String
 
    private var totalPages: Int {
        Int(ceil(Double(self.total / SneakerRequest.pageSize)))
    }
    
    var pageIndicator: String {
        "\(currentPage) / \(totalPages)"
    }
    
    
    init(brand: String) {
        self.brand = brand
    }
    
    func getSneakers() {
        getSneakers(page: 0)
    }
    
    private func getSneakers(page: Int) {
        switch state {
        case .idle:
            state = .loading
        case .loaded(let sneakers):
            state = .loadingMorePages(sneakers)
        default: break
        }
        
        cancellationToken = SneakersDB.sneakers(for: brand, page: page).fetch()
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    self.state = .failed(error)
                }
            }) { value in
                if case .loadingMorePages(let current) = self.state {
                    self.state = .loaded(current + value.results)
                } else {
                    self.state = .loaded(value.results)
                }
                
                self.total = value.count
            }
    }
    
    func getMoreSneakersIfNeeded(item: Sneaker) {
        guard
            case .loaded(let currentList) = state,
            currentPage < totalPages,
            item == currentList.last
        else { return }

        currentPage += 1
        self.getSneakers(page: self.currentPage)
    }
}
