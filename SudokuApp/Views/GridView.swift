//
//  GridView.swift
//  SudokuApp
//
//  Created by Olga on 09.05.2023.
//

import Foundation
import UIKit

class GridView : UIView {

    var controller = GameViewController()
    
    init(controller: GameViewController) {
        super.init(frame: .zero)
        self.controller = controller
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func color(buttons: [UIButton]) -> [UIButton] {
        for j in 0...2 {
            for i in 0...2 {
                buttons[j * 9 + i].backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
                buttons[8 * 9 - j * 9 + i].backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            }
            for i in 6...8 {
                buttons[j * 9 + i].backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
                buttons[8 * 9 - j * 9 + i].backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            }
            for i in 3...5 {
                buttons[i * 9 + j + 3].backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            }
        }
        return buttons
    }
    
    func createRow() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        return stack
    }
    func createCell() -> UIButton {
        let button = UIButton(frame: CGRect(x: 100,
                                            y: 100,
                                            width: 200,
                                            height: 60))
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.4).cgColor
        button.setTitleColor(.systemMint, for: .normal)
        button.setTitle("",
                        for: .normal)
        button.setTitleColor(.systemBlue,
                             for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1.0/1.0).isActive = true
        return button
    }
    
    
    func setGridStackConstraints(gridStack: UIStackView) {
        let view = controller.view
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        gridStack.leadingAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gridStack.trailingAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
        gridStack.bottomAnchor.constraint(equalTo: view!.safeAreaLayoutGuide.bottomAnchor, constant: -300).isActive = true
    }
}
