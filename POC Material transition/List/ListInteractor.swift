//
//  ListInteractort.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import Foundation

protocol ListInteractorInput {
  func getAllImages()
  func getImage(at index: Int)
}

protocol ListInteractorOutput: class {
  func didGetAllImages(_ images: [Data])
  func didGetImage(_ image: Data)
}

class ListInteractor {
  private var repository: ImageRepositoryProtocol
  weak var output: ListInteractorOutput?
  init(repository: ImageRepositoryProtocol) {
    self.repository = repository
  }
}

extension ListInteractor: ListInteractorInput {
  func getImage(at index: Int) {
    guard let image = repository.getImageWithID(index) else { return }
    repository.saveImage(data: image)
    output?.didGetImage(image)
  }

  func getAllImages() {
    output?.didGetAllImages(repository.getAllImages())
  }
}
