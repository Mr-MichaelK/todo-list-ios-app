//
//  DetailsViewController.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 07/06/2025.
//

import UIKit

class DetailsViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    var task: Task!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init(task: Task) {
        super.init(nibName: nil, bundle: nil)
        self.task = task
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
