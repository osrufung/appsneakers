//
//  SneakersListView.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import SwiftUI
import Combine
import KingfisherSwiftUI

struct SneakerRowView: View {
    let sneaker: Sneaker
    
    var body: some View {
        
        HStack {
            if let image = sneaker.imgUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)

            }
            VStack(alignment: .leading, spacing: 10) {
                Text(sneaker.name)
                    .font(.headline)                
                Text(sneaker.priceFormatted)
                    .font(.caption)                
            }
        }
    }
}

struct SneakersListView: View {
    @ObservedObject var viewModel: SneakerListViewModel        
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Color.clear
                    .onAppear(perform: viewModel.getSneakers)
            case .loading:
                ProgressView("Loading sneakers for '\(viewModel.brand)'...")
            case .failed(let error):
                ErrorView(error: "Error '\(error)' found.")
                Button("Reload", action: viewModel.getSneakers)
                .padding()
                Spacer()

            case .loaded(let sneakers), .loadingMorePages(let sneakers):
                List(sneakers, id: \.id) { sneaker in
                NavigationLink(
                    destination: SneakerDetailView(sneaker: sneaker),
                    label: {
                        SneakerRowView(sneaker: sneaker)
                            .onAppear {
                                viewModel.getMoreSneakersIfNeeded(item: sneaker)
                            }
                    })
                }
                if case .loadingMorePages(_) = viewModel.state {
                    Text("Loading page \(viewModel.pageIndicator)")
                        .padding()
                        .background(Color(.systemGray))
                        .opacity(0.7)
                        .font(.subheadline)
                        .cornerRadius(10)
                        .padding()                        
                }
            }
        }        
        .navigationTitle(viewModel.brand)
    }
}

struct SneakersListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SneakersListView(viewModel: SneakerListViewModel(brand: "Nike"))
                .environmentObject(FavouriteSneakers())
        }        
    }
}
