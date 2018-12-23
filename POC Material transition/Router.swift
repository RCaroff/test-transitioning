//
//  Router.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import Foundation
import UIKit

enum Route {
  case list
  case details(origin: HeaderImageTransitionOriginProtocol?)
}

protocol RouterInput {
  func route(to route: Route)
}

class Router {
  private var navigationController: UINavigationController?
  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }
}

extension Router: RouterInput {
  func route(to route: Route) {
    switch route {
    case .list:
      routeToList()
    case .details(let origin):
      routeToDetails(origin: origin)
    }
  }
  
  private func routeToList() {
    guard let controller = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
    let repo = ImageRepository.shared
    let interactor = ListInteractor(repository: repo)
    let presenter = ListPresenter(router: self, interactor: interactor, transitionOrigin: controller)
    presenter.output = controller
    interactor.output = presenter
    controller.presenter = presenter
    
    navigationController?.setViewControllers([controller], animated: false)
  }
  
  private func routeToDetails(origin: HeaderImageTransitionOriginProtocol?) {
    guard let destination = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "DetailsViewController") as? HeaderImageTransitionDestinationProtocol,
    let controller = destination as? DetailsViewController  else { return }
    let repo = ImageRepository.shared
    let interactor = DetailsInteractor(repository: repo)
    let presenter = DetailsPresenter(interactor: interactor)
    presenter.output = controller
    interactor.output = presenter
    controller.presenter = presenter
    
    guard origin != nil else {
      self.navigationController?.pushViewController(controller, animated: true)
      return
    }
    
    controller.loadViewIfNeeded()
    origin?.animateToDestination(destination, completion: { [weak self] presentingVC in
      self?.navigationController?.pushViewController(controller, animated: false)
    })
  }
}
