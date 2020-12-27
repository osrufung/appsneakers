//
//  BrandsListView.swift
//  AppSneakers (iOS)
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import SwiftUI
import Combine

struct BrandsListView: View {
    @StateObject var viewModel = BrandsListViewModel()
    var body: some View {
        List(viewModel.brands, id: \.self) { brand in
            Text(brand)
        }
    }
}

struct BrandsListView_Previews: PreviewProvider {
    static var previews: some View {
        BrandsListView()
    }
}
