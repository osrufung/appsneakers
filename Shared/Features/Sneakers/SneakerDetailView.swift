//
//  SneakerDetailView.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 02/01/2021.
//

import SwiftUI
import KingfisherSwiftUI

struct SneakerImageView: View {
    @GestureState var scale: CGFloat = 1.0
    @Environment(\.presentationMode) var presentationMode
    let imageURL: String?
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack {
                Spacer()
            if let image = imageURL {
                KFImage(URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .infinity, height: .infinity)
                    .rotationEffect(.degrees(-90))
                    .scaleEffect(scale)
                            .gesture(MagnificationGesture()
                                .updating($scale, body: { (value, scale, trans) in
                                    scale = value.magnitude
                                })
                        )
                    
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                           }
                    
                }
                Spacer()
            }
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image.init(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
            })
            .padding()
        }
    }
}

struct SneakerDetailView: View {
    @GestureState var scale: CGFloat = 1
    @State var previewVisible: Bool = false
    let sneaker: Sneaker
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                   
                }, label: {
                    Image.init(systemName: "heart.fill")
                        .font(.largeTitle)
                        .accentColor(.red)
                        
                })
            }
            
            if let image = sneaker.imgUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        previewVisible.toggle()
                    }
            }
            Text(sneaker.story ?? "-")
                .font(.body)
            Text(sneaker.priceFormatted)
            Spacer()
        }
        .padding()
        .navigationTitle(sneaker.name)
        .fullScreenCover(isPresented: $previewVisible, content: {
            SneakerImageView(imageURL: sneaker.imgUrl)
        })
    }
}

struct SneakerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SneakerDetailView(sneaker: Sneaker.sample)
    }
}
