//
//  TaskCellDelegate.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 08/06/2025.
//


protocol TaskCellDelegate: AnyObject {
    func didToggleCheckbox(in cell: TaskCell)
}
