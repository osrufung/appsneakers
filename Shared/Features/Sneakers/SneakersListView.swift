//
//  SneakersListView.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import SwiftUI
import Combine
import KingfisherSwiftUI


struct SneakersListView: View {
    @StateObject var viewModel = SneakerListViewModel()
    
    var body: some View {
        List(viewModel.sneakers) { sneaker in
            VStack(alignment: .leading) {
                Text(sneaker.brand)
                Text(sneaker.shoe)
                if let image = sneaker.media.thumbUrl {
                    KFImage(URL(string: image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)

                }
            }
            
        }
    }
}

struct SneakersListView_Previews: PreviewProvider {
    static var previews: some View {
        SneakersListView()
    }
}
