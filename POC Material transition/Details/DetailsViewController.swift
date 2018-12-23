//
//  DetailsViewController.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  
  enum Constants {
    static let imageHeaderHeight: CGFloat = 250
  }

  @IBOutlet weak var imageView: UIImageView?
  var presenter: DetailsPresenterInput!

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
}

extension DetailsViewController: HeaderImageTransitionDestinationProtocol {
  func headerImageTransitionFinalFrame() -> CGRect {
    return CGRect(x: 0, y: self.imageView!.frame.origin.y, width: self.view.frame.width, height: Constants.imageHeaderHeight)
  }
}

extension DetailsViewController: DetailsPresenterOuput {
  func displayImage(_ image: Data) {
    imageView?.image = UIImage(data: image)
  }
}
