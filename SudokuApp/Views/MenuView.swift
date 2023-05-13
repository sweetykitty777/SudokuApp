//
//  MenuView.swift
//  SudokuApp
//
//  Created by Olga on 09.05.2023.

import UIKit

class MenuView : UIView {
    var controller = MenuViewController()
    
    init(controller: MenuViewController) {
        super.init(frame: .zero)
        self.controller = controller
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createTitle() -> UILabel {
        let title = UILabel()
        title.text = "Select level"
        title.textColor = .systemBlue
        title.font = .boldSystemFont(ofSize: 28)
        title.textColor = .systemBlue
        return title
    }
    
    func createMenuButton(name: String) -> UIButton {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.cornerStyle = .small
        button.configuration?.titleAlignment = .center
        button.configuration?.buttonSize = .large
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle(name, for: .normal)
        button.setTitleColor(.white, for: .normal)
        controller.view.addSubview(button)
        return button
    }
    
}
