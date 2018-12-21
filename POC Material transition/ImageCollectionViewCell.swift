//
//  ImageCollectionViewCell.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var coolImageView: UIImageView?
  func setContent(with image: UIImage) {
    coolImageView?.image = image
  }
    
}
