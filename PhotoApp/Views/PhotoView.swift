//
//  PhotoView.swift
//  PhotoApp
//
//  Created by German Velibekov on 18/12/2020.
//

import SwiftUI

struct PhotoView<I: ImageLoader>: View where I: ObservableObject {
  @StateObject var loader: I
  
  var body: some View {
    Group {
      if let image = loader.image {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        Text("Loading...")
      }
    }
    .navigationTitle("Photo")
    .onAppear{ loader.load() }
    .onDisappear { loader.cancel() }
  }
}

struct PhotoView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoView(loader: StaticImageLoader(imageName: "placeholder"))
  }
}
