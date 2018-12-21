//
//  ViewController.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView?
  var images: [UIImage] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.delegate = self

    for i in 0..<11 {
      images.append(UIImage(named: "\(i)")!)
    }
  }

  func animateTransitionWithImage(_ image: UIImage, initialFrame: CGRect) {
    let imageView = UIImageView(frame: initialFrame)
    imageView.image = image
    imageView.contentMode = .scaleAspectFill
    view.addSubview(imageView)
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.collectionView?.alpha = 0
      imageView.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.bounds.width, height: 200)
    }) { _ in
      self.pushDetailsWithImage(image)
      self.collectionView?.alpha = 1
      imageView.removeFromSuperview()
    }
  }

  func pushDetailsWithImage(_ image: UIImage) {
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    controller.image = image
    navigationController?.pushViewController(controller, animated: false)
  }

  func hideNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
  }
}

extension ListViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
    let imageViewFrame = cell.coolImageView?.convert(cell.coolImageView!.frame, to: view)
    animateTransitionWithImage(cell.coolImageView!.image!, initialFrame: imageViewFrame!)
  }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 100)
  }

}

extension ListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellIdentifier = "ImageCellIdentifier"
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
      return UICollectionViewCell()
    }

    cell.setContent(with: images[indexPath.row])

    return cell
  }
}

extension ListViewController: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.7
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
  }


}
