//
//  ImageRepository.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 23/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import Foundation
import UIKit

protocol ImageRepositoryProtocol {
  func getAllImages() -> [Data]
  func getImageWithID(_ id: Int) -> Data?
  func saveImage(data: Data)
  func getSavedImage() -> Data?
}

class ImageRepository {
  
  static let shared = ImageRepository()
  
  let images: [Data] = [
    imageDataWithName("0"),
    imageDataWithName("1"),
    imageDataWithName("2"),
    imageDataWithName("3"),
    imageDataWithName("4"),
    imageDataWithName("5"),
    imageDataWithName("6"),
    imageDataWithName("7"),
    imageDataWithName("8"),
    imageDataWithName("9"),
    imageDataWithName("10")
  ]
  
  var savedImage: Data?
  
  private static func imageDataWithName(_ name: String) -> Data {
    return UIImage(named: name)?.pngData() ?? Data()
  }
}

extension ImageRepository: ImageRepositoryProtocol {
  func getSavedImage() -> Data? {
    return savedImage
  }
  
  func saveImage(data: Data) {
    savedImage = data
  }
  
  func getAllImages() -> [Data] {
    return images
  }
  
  func getImageWithID(_ id: Int) -> Data? {
    return images[id]
  }
}
