//
//  MenuView.swift
//  SudokuApp
//
//  Created by Olga on 09.05.2023.
//

import UIKit

class GameMenuView : UIView {
    var controller = GameViewController()
    
    init(controller: GameViewController) {
        super.init(frame: .zero)
        self.controller = controller
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackButton() -> UIButton {
        let backStack = UIStackView()
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        controller.view.addSubview(backButton)
        backButton.setTitleColor(.systemMint, for: .normal)
        backButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        backButton.setTitle("",
                            for: .normal)
        backButton.setTitleColor(.systemBlue,
                                 for: .normal)
        backButton.pinLeft(to: controller.view, 20)
        backButton.pinTop(to: controller.view, 50)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }
    
    func configureLabel(level: String) -> UILabel {
        let label = UILabel()
        controller.view.addSubview(label)
        switch level {
            case "1":
                label.text = "Level: Easy"
            case "2":
                label.text = "Level: Medium"
            case "3":
                label.text = "Level: Hard"
            default:break
        }
        label.pinRight(to: controller.view.safeAreaLayoutGuide.trailingAnchor, 20)
        label.pinTop(to: controller.view.safeAreaLayoutGuide.topAnchor, 10)
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }
    func configureHelpButton() -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitle("I need help", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        controller.view.addSubview(button)
        button.pinRight(to: controller.view.safeAreaLayoutGuide.trailingAnchor, 20)
        return button
    }
}
