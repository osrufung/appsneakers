//
//  BrandsListView.swift
//  AppSneakers (iOS)
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import SwiftUI
import Combine

struct BrandsListView: View {    
    struct ReloadItem: View {
        @ObservedObject var viewModel: BrandsListViewModel
        var body: some View {
            Button(action: viewModel.getBrands, label: {
                Image.init(systemName: "arrow.counterclockwise")
            })
        }
    }
    
    @StateObject var viewModel = BrandsListViewModel()
    var body: some View {
        NavigationView {
            VStack {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.getBrands)
            case .loading:
                ProgressView("Loading brands...")
            case .failed(let error):
                ErrorView(error: "Error '\(error)' found.")
                Button("Reload", action: viewModel.getBrands)
                .padding()
                Spacer()
            case .loaded(let brands):
                List(brands, id: \.self) { brand in
                    NavigationLink(
                        destination: SneakersListView(viewModel: SneakerListViewModel(brand: brand)),
                        label: {
                            Text(brand)
                        })
                }.listStyle(PlainListStyle())
            }
            }.navigationTitle("Brands")
            .frame(minWidth: 200)
            .toolbar(content: {
                ReloadItem(viewModel: viewModel)
            })
            
            #if os(macOS)
            Text("Choose a brand")
                .frame(minWidth: 400)
            Text("Choose a sneake")
            #endif
        }
    }
}

struct BrandsListView_Previews: PreviewProvider {
    static var previews: some View {
        BrandsListView()
    }
}
