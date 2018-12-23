//
//  HeaderImageTransitionDelegate.swift
//  POC Material transition
//
//  Created by Rémi Caroff on 21/12/2018.
//  Copyright © 2018 Rémi Caroff. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

protocol HeaderImageTransitionProtocol { }

protocol HeaderImageTransitionOriginProtocol: HeaderImageTransitionProtocol {
  func animateToDestination(_ destination: HeaderImageTransitionDestinationProtocol, completion: @escaping (UIViewController) -> Void)
}

protocol HeaderImageTransitionDestinationProtocol: HeaderImageTransitionProtocol {
  func headerImageTransitionFinalFrame() -> CGRect
}
