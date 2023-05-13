//
//  ConstructorViewController.swift
//  SudokuApp
//
//  Created by Olga on 09.05.2023.
//

import UIKit


class ConstructorViewController : UIViewController {
    private var gridStack = UIStackView()
    private var keyboardStack = UIStackView()
    private var buttons = [UIButton]()
    private let zeroButton = UIButton()
    private var currButton = UIButton()
    var answer = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var gettingMatrix = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        zeroButton.setTitle("", for: .normal)
        currButton = zeroButton
        configureSudoku()
        configureBackButton()
        configureCustomKeyboard()
        color()
    }
    func configureBackButton() {
        let backStack = UIStackView()
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backStack.addArrangedSubview(backButton)
        view.addSubview(backStack)
        backButton.setTitleColor(.systemMint, for: .normal)
        backButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        backButton.setTitle("",
                            for: .normal)
        backButton.setTitleColor(.systemBlue,
                                 for: .normal)
        backButton.pinLeft(to: view, 20)
        backButton.pinTop(to: view, 50)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backStack.translatesAutoresizingMaskIntoConstraints = false
    }
    func trueBack() {
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
    func displayLeaveGame() {
        let dialogMessage = UIAlertController(title: "You are going to leave the game", message: "All changes won't be saved", preferredStyle: .alert)

        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            self.trueBack()
        //    self.deleteRecord()
        })
        let notOK = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
         //   self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(notOK)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    @objc func back() {
        displayLeaveGame()
    }
    
    func configureSudoku() {
        view.addSubview(gridStack)
        gridStack.axis = .vertical
        gridStack.distribution = .fillEqually
        gridStack.spacing = 0
        addHorizontalStacks()
        gridStack.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 50)
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        gridStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gridStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
    }
    func addHorizontalStacks() {
        for _ in 1...9 {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 0
            stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
            addCells(row: stack)
            gridStack.addArrangedSubview(stack)
        }
    }
    
    // добавление ячеек в сетку
    func addCells(row: UIStackView) {
        for i in 1...9 {
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
            button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1.0/1.0).isActive = true
            buttons.append(button)
            row.addArrangedSubview(button)
        }
    }
    @objc func pressed(sender: UIButton) {
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
    
    
    // раскрашиваем поле судоку
    func color() {
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
    }
    
    func setKeyboardConstraints() {
        keyboardStack.translatesAutoresizingMaskIntoConstraints = false
        keyboardStack.topAnchor.constraint(equalTo: gridStack.bottomAnchor, constant: 10).isActive = true
        keyboardStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        keyboardStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
        keyboardStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    func configureCustomKeyboard() {
        view.addSubview(keyboardStack)
        keyboardStack.axis = .vertical
        keyboardStack.distribution = .fillEqually
        keyboardStack.spacing = 10
        addCustomKeyboardButtons()
        setKeyboardConstraints()
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
        button.addTarget(self, action: #selector(pressedChoice), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1.0/1.0).isActive = true
        return button
    }
    @objc func pressedChoice(sender: UIButton) {
        if (currButton != zeroButton) {
            if sender.title(for: .normal) == "Erase" {
                currButton.setTitle("", for: .normal)
            } else {
            currButton.setTitle(sender.title(for: .normal), for: .normal)
            currButton.setTitleColor(.systemBlue, for: .normal)
            sender.layer.borderWidth = 1
            currButton.layer.borderWidth = 1
            currButton = zeroButton
            }
        }
    }
    func addCustomKeyboardButtons() {
        for i in 1...3 {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 10
            stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
            keyboardStack.addArrangedSubview(stack)
            for j in 1...3 {
                let button = createKeyboardButton()
                button.setTitle("\(3 * (i - 1) + j)",
                                for: .normal)
                buttons.append(button)
                stack.addArrangedSubview(button)
            }
        }
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        keyboardStack.addArrangedSubview(stack)
        let button = createKeyboardButton()
        button.setTitle("Erase",
                        for: .normal)
        buttons.append(button)
        stack.addArrangedSubview(button)
        let stack1 = UIStackView()
        stack1.axis = .horizontal
        stack1.distribution = .fillEqually
        stack1.spacing = 10
        stack1.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        keyboardStack.addArrangedSubview(stack1)
        let button1 = UIButton()
        button1.titleLabel?.font = .boldSystemFont(ofSize: 29)
        button1.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.systemBlue.cgColor
        button1.layer.cornerRadius = 5
        button1.setTitleColor(.systemMint, for: .normal)
        button1.setTitleColor(.systemBlue,
                             for: .normal)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.addTarget(self, action: #selector(play), for: .touchUpInside)
        button1.setTitle("Play",
                        for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button1.layer.backgroundColor = UIColor.systemBlue.cgColor
        buttons.append(button1)
        stack1.addArrangedSubview(button1)
    }
    @objc func play() {
        for i in 0..<81 {
            var a = buttons[i].titleLabel?.text
            if (a == "") {
                a = "0"
            }
            var c = 0
          //  var b = Int?(a)
            if let str: String = a, let b = Int(str) {
                  c = b
              }
            gettingMatrix[i / 9][i % 9] = c
        }
        for i in gettingMatrix{
            print(i)
        }
        let solver = SudokuSolver(matrix: gettingMatrix)
        solver.setMatrix(matrix: gettingMatrix)
        var check = 0
        solver.countSolutions(number: &check)

        if (check > 1) {
            let dialogMessage = UIAlertController(title: "Not valid", message: "Sudoku must have only one solution", preferredStyle: .alert)

            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
           //     self.deleteRecord()
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        if (check == 0) {
            let dialogMessage = UIAlertController(title: "Not valid", message: "Sudoku must have a solution", preferredStyle: .alert)

            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
             //   self.deleteRecord()
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        if (check == 1) {
            solver.solveSudoku()
            var matr = solver.getMatrix()
            keyboardStack = UIStackView()
            gridStack = UIStackView()
            answer = matr
            for view1 in self.view.subviews{
                view1.removeFromSuperview()
            }
            buttons = []
            let game = GameViewController()
            game.answer = answer;
            game.sudokuGrid = gettingMatrix
            game.needToGenerate = 0
            game.modalPresentationStyle = .fullScreen
            present(game, animated: false, completion: nil)
        }
    }
}
