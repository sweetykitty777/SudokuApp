//
//  KeyboardView.swift
//  SudokuApp
//
//  Created by Olga on 09.05.2023.
//

import UIKit


class KeyboardView : UIView {
    var controller = GameViewController()
    
    init(controller: GameViewController) {
        super.init(frame: .zero)
        self.controller = controller
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createKeyboardButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 29)
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 5
        button.setTitleColor(.systemMint, for: .normal)
        button.setTitleColor(.systemBlue,
                             for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1.0/1.0).isActive = true
        return button
    }
    
    func setKeyboardConstraints(keyboardStack: UIStackView, gridStack: UIStackView) {
        keyboardStack.translatesAutoresizingMaskIntoConstraints = false
        keyboardStack.topAnchor.constraint(equalTo: gridStack.bottomAnchor, constant: 10).isActive = true
        keyboardStack.leadingAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        keyboardStack.trailingAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
        keyboardStack.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
