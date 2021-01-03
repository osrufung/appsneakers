//
//  AppSneakersApp.swift
//  Shared
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import SwiftUI

class FavouriteSneakers: ObservableObject {
    @Published var favouriteSKUs: [String] = ["1012A885-400"]
}

@main
struct AppSneakersApp: App {
    let favourites = FavouriteSneakers()
    var body: some Scene {
        WindowGroup {
            TabBarView().environmentObject(favourites)
        }
    }
}
