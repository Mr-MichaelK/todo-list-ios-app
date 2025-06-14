//
//  CheckBoxButton.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 08/06/2025.
//

import Foundation
import UIKit

class CheckboxButton: UIButton {
    private(set) var isChecked = false

    var onToggle: ((Bool) -> Void)?

    private let checkedImage = UIImage(systemName: "checkmark.square.fill")
    private let uncheckedImage = UIImage(systemName: "square")

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.setImage(uncheckedImage, for: .normal)
        self.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        self.tintColor = .systemBlue
    }

    @objc private func toggleCheck() {
        isChecked.toggle()
        let image = isChecked ? checkedImage : uncheckedImage
        self.setImage(image, for: .normal)
        onToggle?(isChecked)  // 🔥 Notify the outside world
    }

    func setChecked(_ checked: Bool) {
        isChecked = checked
        let image = isChecked ? checkedImage : uncheckedImage
        self.setImage(image, for: .normal)
    }
}
