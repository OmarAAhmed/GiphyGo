//
//  ProtocolsDirectory.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 09/04/2021.
//

import Foundation
import UIKit

protocol PageViewControllerNavigationProtocol {
    func next(viewController: UIViewController)
}

protocol ReloadDataProtocol {
    func reload()
}
