//
//  ListPresenter.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import Foundation
import UIKit

protocol ListPresenterInput {
  func viewDidLoad()
  func didSelectImage(at index: Int)
}

protocol ListPresenterOutput: class {
  func displayImages(_ images: [Data])
}


class ListPresenter {
  private let router: Router
  weak var output: ListPresenterOutput?
  var transitionOrigin: HeaderImageTransitionOriginProtocol
  var interactor: ListInteractorInput
  init(router: Router, interactor: ListInteractorInput, transitionOrigin: HeaderImageTransitionOriginProtocol) {
    self.router = router
    self.interactor = interactor
    self.transitionOrigin = transitionOrigin
  }
}

extension ListPresenter: ListPresenterInput {
  
  func viewDidLoad() {
    interactor.getAllImages()
  }
  
  func didSelectImage(at index: Int) {
    interactor.getImage(at: index)
  }
}

extension ListPresenter: ListInteractorOutput {
  func didGetAllImages(_ images: [Data]) {
    output?.displayImages(images)
  }
  
  func didGetImage(_ image: Data) {
    self.router.route(to: .details(origin: transitionOrigin))
  }
}
