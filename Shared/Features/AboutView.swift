//
//  AboutView.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 03/01/2021.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                Text("SwiftUI demo app to see and fav your Sneakers 👟. Purpose of this app is to learn, track and follow all the new SwiftUI + Combine features along the time.")
                Text("Follow me at:")
                Link(destination: URL(string: "http://twitter.com/arrozconnori")!, label: {
                    Text("@arrozconnori")
                })
                Text("API powered by:")
                Link(destination: URL(string: "https://tg4.solutions/the-sneaker-database-test-endpoints-available/")!, label: {
                    Text("tg4.solutions")
                })
                      
                Spacer()
            }
            .padding()
            .navigationTitle("About")
        }

    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
