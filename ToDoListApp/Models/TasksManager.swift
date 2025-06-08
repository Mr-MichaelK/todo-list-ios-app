//
//  TasksManager.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 07/06/2025.
//

import Foundation

class TasksManager {
    static let shared = TasksManager()
    
    private let tasksKey = "tasks"
    private(set) var tasks: [Task] = []

    private init() {
        loadTasks()
    }

    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }

    func removeTask(at index: Int) {
        guard tasks.indices.contains(index) else { return }
        tasks.remove(at: index)
        saveTasks()
    }

    func updateTask(at index: Int, with task: Task) {
        guard tasks.indices.contains(index) else { return }
        tasks[index] = task
        saveTasks()
    }

    private func loadTasks() {
        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let savedTasks = try? JSONDecoder().decode([Task].self, from: data) else {
            tasks = []
            return
        }
        tasks = savedTasks
    }

    private func saveTasks() {
        if let data = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(data, forKey: tasksKey)
        }
    }
}
