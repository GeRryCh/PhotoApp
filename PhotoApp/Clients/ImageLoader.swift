//
//  ImageLoader.swift
//  PhotoApp
//
//  Created by German Velibekov on 18/12/2020.
//

import Foundation
import SwiftUI
import Combine

protocol ImageLoader {
  var image: UIImage? { get }
  func load()
  func cancel()
}

class RemoteImageLoader: ImageLoader, ObservableObject {

  @Published var image: UIImage?
  
  private let url: URL
  private var cancallable: AnyCancellable?
  
  init(url: URL) {
    self.url = url
  }
  
  
  func load() {
    cancallable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in self?.image = $0 }
  }
  
  func cancel() {
    cancallable?.cancel()
  }
}

class StaticImageLoader: ImageLoader, ObservableObject {
  @Published var image: UIImage?
  
  private let imageName: String
  
  init(imageName: String) {
    self.imageName = imageName
  }
  
  func load() {
    self.image = UIImage(named: imageName)
  }
  
  func cancel() {}
}
