//
//  DetailsInteractor.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 23/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import Foundation

protocol DetailsInteractorInput {
  func getImage()
}

protocol DetailsInteractorOutput: class {
  func didGetImage(_ image: Data)
}

class DetailsInteractor {
  var repository: ImageRepositoryProtocol
  weak var output: DetailsInteractorOutput?
  
  init(repository: ImageRepositoryProtocol) {
    self.repository = repository
  }
}

extension DetailsInteractor: DetailsInteractorInput {
  func getImage() {
    guard let savedImage = repository.getSavedImage() else { return }
    output?.didGetImage(savedImage)
  }
}
