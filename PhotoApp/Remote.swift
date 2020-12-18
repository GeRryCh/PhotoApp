//
//  Remote.swift
//  PhotoApp
//
//  Created by German Velibekov on 18/12/2020.
//

import Foundation
import Combine

class Remote<T: Decodable>: ObservableObject {
  @Published var data: T?
  
  let url: URL
  
  init(url: URL) {
    self.url = url
  }
  
  func load() {
    URLSession(configuration: .default)
      .dataTask(with: url) { (data, _, error) in
        guard let data = data else {
          fatalError("Data returned nil")
        }
        do {
          self.data = try JSONDecoder().decode(T.self, from: data)
        } catch {
          fatalError("Unable to decode data")
        }
      }.resume()
  }
}
