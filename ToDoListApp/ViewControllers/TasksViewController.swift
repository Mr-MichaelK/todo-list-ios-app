//
//  TasksViewController.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 07/06/2025.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource, TaskCellDelegate {
    
    weak var coordinator: MainCoordinator?
    
    var tasks: [Task] {
        return TasksManager.shared.tasks
    }

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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
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
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        tableView.addGestureRecognizer(doubleTapRecognizer)
        
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
        return TasksManager.shared.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        let task = TasksManager.shared.tasks[indexPath.row]
        cell.taskLabel.text = task.title
        cell.checkBox.setChecked(task.isCompleted)
        cell.delegate = self  // ✅ Hook this up
        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath:IndexPath) {
        if editingStyle == .delete {
            TasksManager.shared.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func didToggleCheckbox(in cell: TaskCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var updatedTask = TasksManager.shared.tasks[indexPath.row]
        updatedTask.isCompleted.toggle()
        TasksManager.shared.updateTask(at: indexPath.row, with: updatedTask)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    
    @objc func addButtonTapped() {
        guard let taskText = taskInput.text, !taskText.isEmpty else {
            // Optionally, show an alert or just return
            return
        }
        let newTask = Task(title: taskText, isCompleted: false)
        TasksManager.shared.addTask(newTask)
        tableView.reloadData()
        taskInput.text = ""
        taskInput.resignFirstResponder()
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: location) {
            let selectedTask = TasksManager.shared.tasks[indexPath.row]
            coordinator?.goToDetailsVC(task: selectedTask)
        }
    }

}
