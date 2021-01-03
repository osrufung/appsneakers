//
//  FavouritesSneakers.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 03/01/2021.
//

import SwiftUI

struct FavouritesSneakers: View {
    @EnvironmentObject var settings: FavouriteSneakers
    var body: some View {
        NavigationView {
            List(settings.favouriteSKUs, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Favourites")
        }
    }
}

struct FavouritesSneakers_Previews: PreviewProvider {
    static var previews: some View {
            FavouritesSneakers().environmentObject(FavouriteSneakers())
    }
}
