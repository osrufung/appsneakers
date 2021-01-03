//
//  AccesoryViews.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 03/01/2021.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    var body: some View {
        Text(error)
            .padding()
            .background(Color(.systemRed))
            .cornerRadius(10)
            .padding()
    }
}

struct AccesoryViews_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Something failed :(")
            .preferredColorScheme(.light)
    }
}
