//
//  Coordinator.swift
//  HSE Clubs

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var parent: Coordinator? { get }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    init(navigationController: UINavigationController)
    func start()
}
