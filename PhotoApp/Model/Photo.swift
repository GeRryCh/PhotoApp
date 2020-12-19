//
//  Photo.swift
//  PhotoApp
//
//  Created by German Velibekov on 18/12/2020.
//

import Foundation

struct Photo: Hashable, Decodable {
  let id: String
  let author: String
  let width: Double
  let height: Double
  let url: String
  let download_url: String
}
