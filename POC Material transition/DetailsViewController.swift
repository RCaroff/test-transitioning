//
//  DetailsViewController.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView?

  var image: UIImage!

  override func viewDidLoad() {
    super.viewDidLoad()
    imageView?.image = image
  }
}
