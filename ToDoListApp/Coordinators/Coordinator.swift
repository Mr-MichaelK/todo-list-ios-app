//
//  Coordinator.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 07/06/2025.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
 
