//
//  AuthorListView.swift
//  PhotoApp
//
//  Created by German Velibekov on 18/12/2020.
//

import SwiftUI

struct AuthorListView: View {
  @ObservedObject var remote = Remote<[Photo]>(
    url: URL(string: "https://picsum.photos/v2/list")!
  )
  var body: some View {
    NavigationView {
      List {
        if let photos = remote.data {
          ForEach(photos, id: \.self) { (photo: Photo) in
            NavigationLink(destination: PhotoView()) {
              Text(photo.author)
            }
          }
        } else {
          Text("Loading...")
        }
      }
    }.onAppear { remote.load() }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    AuthorListView()
  }
}
