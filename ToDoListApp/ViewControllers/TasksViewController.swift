//
//  TasksViewController.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 07/06/2025.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource {
    
    weak var coordinator: MainCoordinator?
    
    var tasks: [Task] = [
        Task(title: "Go shopping", isCompleted: false),
        Task(title: "Do HW", isCompleted: true)
    ]
    
    let tableView = UITableView()
    let taskInput: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter task"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = .white
        button.layer.cornerRadius = 22
        button.configuration?.titleAlignment = .center
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 12
        sv.alignment = .center
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        stackView.addArrangedSubview(taskInput)
        stackView.addArrangedSubview(addButton)
        
        view.addSubview(stackView)
        view.addSubview(tableView)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            // stackView pinned top with some padding
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // taskInput expands to fill remaining space in stackView
            taskInput.heightAnchor.constraint(equalToConstant: 44),
            
            // tableView below stackView
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.title
        cell.checkBox.setChecked(task.isCompleted)
        return cell
    }
    
    @objc func addButtonTapped() {
        guard let taskText = taskInput.text, !taskText.isEmpty else {
            // Optionally, show an alert or just return
            return
        }
        let newTask = Task(title: taskText, isCompleted: false)
        tasks.append(newTask)
        tableView.reloadData()
        taskInput.text = ""
        taskInput.resignFirstResponder()
    }

}
