//
//  MainCoordinator.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 07/06/2025.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tasksVC = TasksViewController()
        tasksVC.coordinator = self
        navigationController.pushViewController(tasksVC, animated: false)
    }
    
    func goToDetailsVC(task: Task) {
        let detailsVC = DetailsViewController(task: task)
        detailsVC.coordinator = self
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
