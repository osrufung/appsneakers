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



struct CellView: View {
    let value: String
    let title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.headline)
            Text(title)
                .font(.subheadline)
        }
    }
}

struct AccesoryViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(error: "Something failed :(")
                .preferredColorScheme(.light)
            CellView(value: "Value content", title: "Title")

        }
    }
}
