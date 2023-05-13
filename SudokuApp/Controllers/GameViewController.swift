//
//  GameViewController.swift
//  SudokuApp
//
//  Created by Olga on 09.05.2023.
//

import UIKit

class GameViewController : UIViewController {
    var level = ""
    private var gridStack = UIStackView()
    private var keyboardStack = UIStackView()
    private var buttons = [UIButton]()
    private let zeroButton = UIButton()
    private var currButton = UIButton()
    var answer = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var sudokuGrid: [[Int]] = []
    var needToGenerate = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        zeroButton.setTitle("", for: .normal)
        currButton = zeroButton
        generateSudoku()
        setUpFieldUI()
        setUpGameMenuUI()
    }
    
    private func setUpFieldUI() {
        configureStackView()
        for i in 0..<9 {
            for j in 0..<9 {
                let name = String(sudokuGrid[i][j]) == "0" ? "" : String(sudokuGrid[i][j])
                if (name != "") {
                    buttons[9 * i + j].isEnabled = false
                    buttons[9 * i + j].setTitleColor(.black, for:.normal)
                }
                buttons[9 * i + j].setTitle(name, for: .normal)
            }
        }
        buttons = GridView(controller: self).color(buttons:buttons)
    }
    
    private func setUpGameMenuUI() {
        GameMenuView(controller: self).configureLabel(level: level)
        let button = GameMenuView(controller: self).configureHelpButton()
        button.addTarget(self, action: #selector(menuHelp), for: .touchUpInside)
        button.pinTop(to: gridStack, -35)
        
        configureKeyboard()
        let backButton = GameMenuView(controller: self).configureBackButton()
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    
    
    // Создание клавиатуры
    private func configureKeyboard() {
        view.addSubview(keyboardStack)
        keyboardStack.axis = .vertical
        keyboardStack.distribution = .fillEqually
        keyboardStack.spacing = 10
        addKeyboardButtons()
        KeyboardView(controller: self).setKeyboardConstraints(keyboardStack: keyboardStack, gridStack: gridStack)
    }
    
    
    
    @objc private func back() {
        displayLeaveGame()
    }
    private func displayLeaveGame() {
        let dialogMessage = UIAlertController(title: "You are going to leave the game", message: "All changes won't be saved", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            self.trueBack()
            //   self.deleteRecord()
        })
        let notOK = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            // self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(notOK)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    private func trueBack() {
        let myView = self.view
        gridStack = UIStackView()
        keyboardStack = UIStackView()
        for i in 0..<9 {
            for j in 0..<9 {
                buttons[9*i + j].isEnabled = true
                buttons[9*i + j].setTitleColor(.black, for:.normal)
                buttons[9*i + j].setTitle("", for: .normal)
            }
        }
        buttons.removeAll()
        if let myView = myView {
            for subview in myView.subviews {
                subview.removeFromSuperview()
            }
        }
        let menu = MenuViewController()
        menu.modalPresentationStyle = .fullScreen
        present(menu, animated: false, completion: nil)
    }
    
    
    // добавление клавиш для судоку
    private func addKeyboardButtons() {
        for i in 1...3 {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 10
            stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
            keyboardStack.addArrangedSubview(stack)
            for j in 1...3 {
                let button = KeyboardView(controller:self).createKeyboardButton()
                button.addTarget(self, action: #selector(pressedChoice), for: .touchUpInside)
                button.setTitle("\(3 * (i - 1) + j)", for: .normal)
                buttons.append(button)
                stack.addArrangedSubview(button)
            }
        }
    }
    
    // создание типичной кнопки в игре
    private func createGameButton(name: String) -> UIButton {
        let btn = UIButton()
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 1
        btn.setTitle(name, for: .normal)
        btn.setTitleColor(.systemBlue,
                          for: .normal)
        btn.layer.borderWidth = 0
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return btn
    }
    
    
    @objc private func menuHelp() {
        let dialogMessage = UIAlertController(title: "Help", message: "You can get a hint, check your mistakes or discover our solution", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Mistakes", style: .default, handler: { (action) -> Void in
            self.findMistakes()
            //  self.deleteRecord()
        })
        let ok1 = UIAlertAction(title: "Hint", style: .default, handler: { (action) -> Void in
            self.hint()
            //  self.deleteRecord()
        })
        let ok2 = UIAlertAction(title: "Solution", style: .default, handler: { (action) -> Void in
            self.checker()
            //   self.deleteRecord()
        })
        let ok3 = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            //  self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(ok1)
        dialogMessage.addAction(ok2)
        dialogMessage.addAction(ok3)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    @objc func findMistakes() {
        for i in 0..<9 {
            for j in 0..<9 {
                let answ = String(answer[i][j])
                if (buttons[9 * i + j].title(for: .normal) != answ && buttons[9 * i + j].title(for: .normal) != "") {
                    buttons[9 * i + j].setTitleColor(.red, for: .normal)
                }
            }
        }
    }
    @objc private func checker() {
        for i in 0..<9 {
            for j in 0..<9 {
                let answ = String(answer[i][j])
                if (buttons[9 * i + j].title(for: .normal) != answ) {
                    buttons[9 * i + j].setTitleColor(.red, for: .normal)
                    if (buttons[9 * i + j].title(for: .normal) == "") {
                        buttons[9 * i + j].setTitleColor(.systemIndigo, for: .normal)
                    }
                    buttons[9 * i + j].setTitle(answ, for: .normal)
                } else {
                    if (buttons[9 * i + j].titleColor(for: .normal) != .black) {
                        buttons[9 * i + j].setTitleColor(.green, for: .normal)
                    }
                }
            }
        }
        winCheck()
    }
    
    @objc private func hint() {
        var x = Int.random(in: 0..<9)
        var y = Int.random(in: 0..<9)
        while (buttons[9 * x + y].title(for: .normal) != "") {
            x = Int.random(in: 0..<9)
            y = Int.random(in: 0..<9)
        }
        buttons[9 * x + y].setTitle(String(answer[x][y]), for: .normal)
        buttons[9 * x + y].setTitleColor(.systemIndigo, for: .normal)
        buttons[9 * x + y].isEnabled = false
        winCheck()
    }
    
    // извлекаем из нашей model сгенерированный вариант судоку и решение
    private func generateSudoku() {
        if (needToGenerate == 1) {
            let generator = SudokuGenerator()
            let result = generator.getSudokuWithGaps(level: self.level)
            sudokuGrid = result.question
            answer = generator.getAnswer()
        }
    }
    
    // добавление сетки судоку
    private func configureStackView() {
        view.addSubview(gridStack)
        gridStack.axis = .vertical
        gridStack.distribution = .fillEqually
        gridStack.spacing = 0
        addHorizontalStacks()
        GridView(controller: self).setGridStackConstraints(gridStack: gridStack)
    }
    
    // добавление строк судоку
    private func addHorizontalStacks() {
        for _ in 1...9 {
            let stack = GridView(controller: self).createRow()
            addCells(row: stack)
            gridStack.addArrangedSubview(stack)
        }
    }
    
    
    // добавление ячейки
    private func addCells(row: UIStackView) {
        for _ in 1...9 {
            let button = GridView(controller: self).createCell()
            button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            buttons.append(button)
            row.addArrangedSubview(button)
        }
    }
    
    // обработка нажатия на клавиатуру
    @objc private func pressedChoice(sender: UIButton) {
        if (currButton != zeroButton) {
            if sender.title(for: .normal) == "Erase" {
                currButton.setTitle("", for: .normal)
            } else {
                currButton.setTitle(sender.title(for: .normal), for: .normal)
                currButton.setTitleColor(.systemBlue, for: .normal)
                sender.layer.borderWidth = 1
                currButton.layer.borderWidth = 1
                currButton = zeroButton
                winCheck()
            }
        }
    }
    // заполнены ли все ячейки верно
    private func winCheck() -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                let answ = String(answer[i][j])
                if (buttons[9 * i + j].title(for: .normal) != answ) {
                    return false
                }
            }
        }
        displayAlert()
        return true
    }
    // алерт о завершении игры
    private func displayAlert() {
        let dialogMessage = UIAlertController(title: "The game is over!", message: "All cells are filled correctly", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Stay here", style: .default, handler: { (action) -> Void in
            //    self.deleteRecord()
        })
        let ok2 = UIAlertAction(title: "Go to menu", style: .default, handler: { (action) -> Void in
            //   self.trueBack()
            //    self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(ok2)
        self.present(dialogMessage, animated: true, completion: nil)
        
        
    }
    
    // обработка выбора cell-а
    @objc private func pressed(sender: UIButton) {
        if (sender.layer.borderWidth == 3) {
            sender.layer.borderWidth = 1
        } else {
            sender.layer.borderWidth = 3
            currButton = sender
            for i in 0...buttons.count - 1{
                if (buttons[i] != sender) {
                    buttons[i].layer.borderWidth = 1
                }
            }
        }
    }
    
}
