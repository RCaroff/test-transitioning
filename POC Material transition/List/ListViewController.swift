//
//  ViewController.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  
  var presenter: ListPresenterInput!

  @IBOutlet weak var collectionView: UICollectionView?
  var images: [UIImage] = []
  var selectedImageViewFrame: CGRect?
  var selectedImage: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.delegate = self
    presenter.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showNavigationBar()
  }

  func hideNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    //self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  func showNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    navigationController?.navigationBar.shadowImage = nil
    //self.navigationController?.setNavigationBarHidden(false, animated: true)
  }
}

extension ListViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell,
    let iv = cell.coolImageView else { return }
    selectedImageViewFrame = iv.convert(iv.frame, to: view)
    selectedImage = iv.image
    presenter.didSelectImage(at: indexPath.item)
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

extension ListViewController: HeaderImageTransitionOriginProtocol {
  func animateToDestination(_ destination: HeaderImageTransitionDestinationProtocol, completion: @escaping (UIViewController) -> Void) {
    guard let initialFrame = selectedImageViewFrame else { return }
    hideNavigationBar()
    let imageView = UIImageView(frame: initialFrame)
    imageView.image = selectedImage
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    view.addSubview(imageView)
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 15, options: .curveEaseOut, animations: {
      self.collectionView?.alpha = 0
      imageView.frame = destination.headerImageTransitionFinalFrame()
    }) { [weak self] _ in
      guard let strongSelf = self else { return }
      completion(strongSelf)
      self?.collectionView?.alpha = 1
      imageView.removeFromSuperview()
    }
  }
}

extension ListViewController: ListPresenterOutput {
  func displayImages(_ images: [Data]) {
    self.images = images.compactMap({ UIImage(data: $0) })
    collectionView?.reloadData()
  }
}
