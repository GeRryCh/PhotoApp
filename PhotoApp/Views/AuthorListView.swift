//
//  AuthorListView.swift
//  PhotoApp
//
//  Created by German Velibekov on 18/12/2020.
//

import SwiftUI

struct AuthorListView: View {
  @StateObject var remote = Remote<[Photo]>(
    url: URL(string: "https://picsum.photos/v2/list")!
  )
  var body: some View {
    NavigationView {
      List {
        if let photos = remote.data {
          ForEach(photos, id: \.self) { (photo: Photo) in
            NavigationLink(
              destination: PhotoView(loader: RemoteImageLoader(url: URL(string: photo.download_url)!))
            ) {
              Text(photo.author)
            }
          }
        } else {
          Text("Loading...")
        }
      }
      .navigationTitle("Authors")
    }.onAppear { remote.load() }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AuthorListView()
  }
}
