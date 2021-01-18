//
//  SneakerDetailView.swift
//  AppSneakers
//
//  Created by Oswaldo Rubio on 02/01/2021.
//

import SwiftUI
import KingfisherSwiftUI

struct SneakerFullSizeImageView: View {
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

struct SneakerImagePreviewView: View {
    let sneaker: Sneaker
    @Binding var previewVisible: Bool
    @EnvironmentObject var settings: FavouriteSneakers
    var body: some View {
        VStack(spacing: 20) {
    
            if let image = sneaker.imgUrl {
                KFImage(URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        previewVisible.toggle()
                    }
            }
        }
    }
}


struct SneakerDetailView: View {
    @EnvironmentObject var settings: FavouriteSneakers
    @GestureState var scale: CGFloat = 1
    @State var previewVisible: Bool = false
    
    let sneaker: Sneaker
    var body: some View {
        List {
            SneakerImagePreviewView(sneaker: sneaker, previewVisible: $previewVisible)
            Section(header: Text("Info")) {
                CellView(value: sneaker.sku, title: "SKU")
                CellView(value: sneaker.brand, title: "Brand")
                CellView(value: sneaker.gender, title: "gender")
                CellView(value: sneaker.colorway, title: "colorway")
                CellView(value: sneaker.dateFormatted ?? "-", title: "release Date")
            }
            if sneaker.story?.isEmpty == false {
                Section(header: Text("Story")) {
                    Text(sneaker.story!)
                }
            }
            Section(header: Text("Shop")) {
                Text("link")
            }
            Section(header: Text("Actions")) {
                Button(action: {
                    settings.toggle(sneaker.sku)
                }, label: {
                    if settings.favouriteSKUs.contains(sneaker.sku) {
                        Text("Remove from favourites")
                    } else {
                        Text("Add to favourites")
                    }        
                })
            }
        }
        .navigationTitle(sneaker.name)
        .fullScreenCover(isPresented: $previewVisible, content: {
            SneakerFullSizeImageView(imageURL: sneaker.imgUrl)
        })
    }
}

struct SneakerDetailView_Previews: PreviewProvider {
    static let sneaker = Sneaker(sku: "123",
                          brand: "Asics",
                          name: "Wmns Solution Speed 'Pink Glow",
                          gender: "men",
                          colorway: "blue",
                          story: "The ASICS women’s Gel Lyte 3 ‘Black...",
                          releaseYear: 2010,
                          releaseDate: Date(),
                          imgUrl: "https://image.goat.com/750/attachments/product_template_pictures/images/047/923/713/original/1192A193_001.png.png",
                          retailPrice: nil)
    static var previews: some View {
        NavigationView {
            SneakerDetailView(sneaker: sneaker)
                .environmentObject(FavouriteSneakers())
                .navigationBarTitleDisplayMode(.inline)

        }
    }
}
