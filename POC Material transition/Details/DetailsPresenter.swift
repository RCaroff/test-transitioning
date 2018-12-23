//
//  DetailsPresenter.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 23/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import Foundation
protocol DetailsPresenterInput {
  func viewDidLoad()
}

protocol DetailsPresenterOuput: class {
  func displayImage(_ image: Data)
}

class DetailsPresenter {

  private var interactor: DetailsInteractorInput
  weak var output: DetailsPresenterOuput?
  
  init(interactor: DetailsInteractorInput) {
    self.interactor = interactor
  }
}

extension DetailsPresenter: DetailsPresenterInput {
  func viewDidLoad() {
    interactor.getImage()
  }
}

extension DetailsPresenter: DetailsInteractorOutput {
  func didGetImage(_ image: Data) {
    output?.displayImage(image)
  }
}
