//
//  MenuViewController.swift
//  SudokuApp
//
//  Created by Olga on 09.05.2023.
//

import UIKit

class MenuViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpMenu()
    }
    // меню выбора уровня
    private func setUpMenu () {
        let title = MenuView(controller: self).createTitle()
        let screen = UIStackView()
        let menuStack = UIStackView()
        menuStack.axis = .vertical
        menuStack.spacing = 30
        let levels = ["Easy", "Medium", "Hard"]
        for i in levels {
            let button = MenuView(controller: self).createMenuButton(name: i)
            button.addTarget(self, action: #selector(getLevel), for: .touchUpInside)
            menuStack.addArrangedSubview(button)
        }
        let button = MenuView(controller: self).createMenuButton(name: "Custom game")
        button.addTarget(self, action: #selector(uploadGame), for: .touchUpInside)
        menuStack.addArrangedSubview(button)
        
        view.addSubview(menuStack)
        screen.addArrangedSubview(menuStack)
        screen.axis = .vertical
        screen.spacing = 50
        view.addSubview(screen)
        view.addSubview(title)
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        title.pinTop(to: menuStack.topAnchor, -80)
        screen.pinCenter(to: view)
        menuStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
    }
    

    @objc private func getLevel(sender: UIButton) {
        let ans = String(sender.title(for: .normal) ?? "1")
        var level = "0"
        if (ans == "Easy") {
            level = "1"
        }
        if (ans == "Medium") {
            level = "2"
        }
        if (ans == "Hard") {
            level = "3"
        }
        let myView = self.view
        if let myView = myView {
            for subview in myView.subviews {
                subview.removeFromSuperview()
            }
        }
        let game = GameViewController()
        game.level = level
        game.modalPresentationStyle = .fullScreen
        present(game, animated: false, completion: nil)
    }
    
    @objc func uploadGame() {
        let myView = self.view
        if let myView = myView {
            for subview in myView.subviews {
                subview.removeFromSuperview()
            }
        }
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        let constr = ConstructorViewController()
        constr.modalPresentationStyle = .fullScreen
        present(constr, animated: false, completion: nil)
    }
}
