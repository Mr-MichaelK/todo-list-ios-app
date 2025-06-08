//
//  TaskCell.swift
//  ToDoListApp
//
//  Created by Michael Kolanjian on 07/06/2025.
//

import UIKit

class TaskCell: UITableViewCell {
    
    //let taskTitle: String
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkBox = CheckboxButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(taskLabel)
        contentView.addSubview(checkBox)

        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.isUserInteractionEnabled = true
        
        self.selectionStyle = .none

        NSLayoutConstraint.activate([
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: 24),
            checkBox.heightAnchor.constraint(equalToConstant: 24),
            
            taskLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 12),
            taskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            taskLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
