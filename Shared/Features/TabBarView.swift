//
//  TabBarView.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            BrandsListView()
                .tabItem {
                    Label("Brands", systemImage: "applelogo")
                }
            FavouritesSneakers()
                .tabItem { Label("Favourites", systemImage: "heart.fill") }
            AboutView()
                .tabItem { Label("About", systemImage: "info.circle") }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
