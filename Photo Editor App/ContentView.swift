//
//  ContentView.swift
//  Photo Editor App
//
//  Created by macbook on 2021/10/12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var imageController: ImageController
    @State var showImagePicker = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Image(uiImage: self.imageController.displayedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width,height: geometry.size.height*(3/4))
                        .clipped()
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ThumbnailView(filter: .Original, width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Original")
                            ThumbnailView(filter: .Sepia, width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Sepia")
                            ThumbnailView(filter: .Mono, width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Mono")
                            ThumbnailView(filter: .Vibrance, width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Vibrance")
                        }
                    }.frame(width: geometry.size.width, height: geometry.size.height*(1/4))
                }
            }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(imageController: self.imageController, showImagePicker: self.$showImagePicker)
            })
            .navigationBarTitle("Filter App", displayMode: .inline)
            .navigationBarItems(leading: LeadingNavigationBarItems(showImagePicker: $showImagePicker), trailing: TraillingNavigationBarItem())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ImageController())
    }
}

struct ThumbnailView: View {
    @EnvironmentObject var imageController: ImageController
    var filter: FilterType
    var width: CGFloat
    var height: CGFloat
    var filterName: String
    var body: some View {
        Button(action: {self.imageController.displayedImage = self.imageController.generateFilteredImage(inputImage: self.imageController.originalImage!, filter: self.filter)}, label: {
            VStack{
                Text(filterName)
                    .foregroundColor(.black)
                Image(uiImage: imageController.generateFilteredImage(inputImage: imageController.thumbnailImage!, filter: filter))
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(20)
                    .frame(width: width, height:height)
                    .clipped()
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
        })
    }
}

struct LeadingNavigationBarItems: View {
    @Binding var showImagePicker: Bool
    var body: some View {
        (
            HStack{
                Button(action: {self.showImagePicker = true}, label: {
                    Image(systemName: "photo")
                        .foregroundColor(Color(UIColor.black))
                        .imageScale(.large)
                })
                Button(action: {print("Open camera")}, label: {
                    Image(systemName: "camera")
                        .foregroundColor(Color(UIColor.black))
                        .imageScale(.large)
                })
            }
        )
    }
}

struct TraillingNavigationBarItem: View {
    @EnvironmentObject var imageController: ImageController
    var body: some View {
        Button(action: {self.imageController.saveImage()}, label: {
            Image(systemName: "square.and.arrow.down")
                .foregroundColor(Color(UIColor.black))
                .imageScale(.large)
        })
    }
}
