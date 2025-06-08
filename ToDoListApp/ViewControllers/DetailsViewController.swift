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
    
    let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let taskStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(taskTitleLabel)
        view.addSubview(taskStatusLabel)
        
        taskTitleLabel.text = task.title
        taskStatusLabel.text = task.isCompleted ? "Completed" : "Not completed"
        
        taskTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        taskTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        taskStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        taskStatusLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    init(task: Task) {
        super.init(nibName: nil, bundle: nil)
        self.task = task
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
