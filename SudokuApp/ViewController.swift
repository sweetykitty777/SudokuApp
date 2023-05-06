//
//  ViewController.swift
//  SudokuApp
//
// sorry for cringe-coding
//  Created by Olga on 08.03.2023.
//

import UIKit


class ViewController: UIViewController {
    private var gridStack = UIStackView()
    private var keyboardStack = UIStackView()
    private var buttons = [UIButton]()
    private let zeroButton = UIButton()
    private var currButton = UIButton()
    private var level = "1"
    private var timerLabel = UILabel()
    var timer = Timer()
    var answer = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    
    
    private var layout : UICollectionViewFlowLayout {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let boundSize: CGSize = UIScreen.main.bounds.size
        layout.itemSize = CGSize(width: boundSize.width, height: 50)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpMenu()
    }
    
    // меню выбора уровня
    func setUpMenu () {
     //   self.navigationItem.backBarButtonItem
        let menuStack = UIStackView()
    //    menuStack.alignment = .fille
     //   let menuStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 20, height: 100))
        menuStack.axis = .vertical
     //   menuStack.alignment = .fill
        menuStack.spacing = 30
       // menuStack.addArrangedSubview(createCustomGameButton())
        menuStack.addArrangedSubview(createMenuButton(name: "Легчайший"))
        menuStack.addArrangedSubview(createMenuButton(name: "Базовая база"))
        menuStack.addArrangedSubview(createMenuButton(name: "Смертельно"))
        view.addSubview(menuStack)
        setMenuConstraints(menu: menuStack)
    }
    
    func createCustomGameButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Upload custom game", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func getImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }

    
    // создание кнопки меню
    func createMenuButton(name: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle(name, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getLevel), for: .touchUpInside)
        return button
    }
    @objc func uploadImage(sender: UIButton) {
        let imageURL = URL(string: "https://example.com/image.jpg")!
        getImage(from: imageURL) { image in
            // Do something with the image, like display it in a UIImageView
          //  imageView.image = image
        }
        /*let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .photoLibrary
            present(imagePickerVC, animated: true)*/
    }
    // constraints для меню
    func setMenuConstraints(menu: UIStackView) {
        menu.pinCenter(to: view)
     /*  menu.translatesAutoresizingMaskIntoConstraints = false
        menu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        menu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400).isActive = true
        menu.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        menu.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
   */
      }
    
    // определение уровня на котором мы играем
    @objc func getLevel(sender: UIButton) {
        let ans = String(sender.title(for: .normal) ?? "1")
        if (ans == "Легчайший") {
            level = "1"
        }
        if (ans == "Базовая база") {
            level = "2"
        }
        if (ans == "Смертельно") {
            level = "3"
        }
        
        let myView = self.view
        if let myView = myView {
            for subview in myView.subviews {
                subview.removeFromSuperview()
            }
        }
        setUpGameView()
    }
    
    // создание кнопки, которая переводит нас в меню уровней
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
       // backButton.pinCenter(to: view.safeAreaLayoutGuide.topAnchor)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
          backStack.translatesAutoresizingMaskIntoConstraints = false
     //   backStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
      //  backStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
   //     backStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
    }
    
    // переход в меню уровней
    @objc func back() {
        displayLeaveGame()
        /*let myView = self.view
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
        setUpMenu()*/
    }
    
    func trueBack() {
        let myView = self.view
        timer.invalidate()
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
        setUpMenu()
    }
    
    @objc func timeUpdate() {
        let time = -(self.timer.userInfo as! NSDate).timeIntervalSinceNow
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        timerLabel.text =  String(format:"%02i:%02i:%02i", hours, minutes, seconds)
      /*  if (elapsed < 60) {
            timerLabel.text = String(format: "%.0f", elapsed)
        } else {
            timerLabel.text = String(format: "%.0f:%.0f", elapsed/60, elapsed)
        }*/
    }
    
    // отрисовка игрового поля
    func setUpGameView() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: NSDate(), repeats: true)
        
        self.view.addSubview(timerLabel)
        timerLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        
        let label = UILabel()
        self.view.addSubview(label)
    //    label.textAlignment = .center;
       // label.pinCenter(to: view.safeAreaLayoutGuide.topAnchor)
        //label.pinCenter(to: v)
        label.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        label.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 180)
     //   label.font = label.font.withSize(18)
        label.font = .boldSystemFont(ofSize: 18)
        timerLabel.pinLeft(to: label, 20)
     //   label.textColor =
        
    //    label.setTitleColor(.systemBlue,
     //                                for: .normal)
       // label.layer.borderWidth = 0
     //   label.titleLabel?.font = .boldSystemFont(ofSize: 18)
        switch level {
            case "1":
                label.text = "Easy"
            case "2":
                label.text = "Medium"
            case "3":
                label.text = "Hard"
            default:break
        }
       //     label.textAlignment = .center
        zeroButton.setTitle("", for: .normal)
        currButton = zeroButton
        configureStackView()
        configureBackButton()
        configureKeyboard()
        let generator = SudokuGenerator()
        let result = generator.getSudokuWithGaps(level: self.level)
        let sudokuGrid = result.question
        answer = generator.getAnswer()
        // расставляем циферки
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
        configureButtonStack()
        color()
        
    }
    
    // создание кнопок актуальных во время игры в стаке
    func configureButtonStack() {
        let buttonStack = UIStackView()
        buttonStack.backgroundColor = .white
        
        let mistakesButton = createGameButton(name: "Мои ошибки")
        mistakesButton.addTarget(self, action: #selector(findMistakes), for: .touchUpInside)
        
        let hintsButton = createGameButton(name: "Подсказка")
        hintsButton.addTarget(self, action: #selector(hint), for: .touchUpInside)
        
        let answersButton = createGameButton(name: "Решение")
        answersButton.addTarget(self, action: #selector(checker), for: .touchUpInside)
        
        let pauseButton = createGameButton(name: "Stop")
        pauseButton.addTarget(self, action: #selector(displayPause), for: .touchUpInside)
        view.addSubview(pauseButton)
        pauseButton.pinTop(to: timerLabel)
        
        buttonStack.addArrangedSubview(answersButton)
        buttonStack.addArrangedSubview(mistakesButton)
        buttonStack.addArrangedSubview(hintsButton)
        
        view.addSubview(buttonStack)
        
        buttonStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .fillEqually
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
    }
    
    // создание типичной кнопки в игре
    func createGameButton(name: String) -> UIButton {
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
    
    // заполнены ли все ячейки верно
    func winCheck() -> Bool {
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
    
    // пометка ошибок красным
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
    
    
    // одна из пустых ячеек становится заполненной правильным числом
    @objc func hint() {
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
    
    // правильное решение
    @objc func checker() {
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
    
    // Создание клавиатуры
    func configureKeyboard() {
        view.addSubview(keyboardStack)
        keyboardStack.axis = .vertical
        keyboardStack.distribution = .fillEqually
        keyboardStack.spacing = 10
        addKeyboardButtons()
        setKeyboardConstraints()
    }

    
    func setKeyboardConstraints() {
        keyboardStack.translatesAutoresizingMaskIntoConstraints = false
        keyboardStack.topAnchor.constraint(equalTo: gridStack.bottomAnchor, constant: 10).isActive = true
        keyboardStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        keyboardStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
        keyboardStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    // добавление клавиш для судоку
    func addKeyboardButtons() {
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
    }
    
    // создание клавиш клавиатуры
    
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
    
    // строки судоку
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
            button.setTitle("\(i)",
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
    
    // обработка нажатия на клавиатуру
    @objc func pressedChoice(sender: UIButton) {
        if (currButton != zeroButton) {
            currButton.setTitle(sender.title(for: .normal), for: .normal)
            currButton.setTitleColor(.systemBlue, for: .normal)
            sender.layer.borderWidth = 1
            currButton.layer.borderWidth = 1
            currButton = zeroButton
            winCheck()
        }
    }
    
    
    // обработка выбора cell-а
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
    
    // создание сетки
    func configureStackView() {
        view.addSubview(gridStack)
        gridStack.axis = .vertical
        gridStack.distribution = .fillEqually
        gridStack.spacing = 0
        addHorizontalStacks()
        setGridStackConstraints()
    }
    
    // constraints для сетки
    func setGridStackConstraints() {
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        gridStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gridStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
        gridStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300).isActive = true
    }
    
    
    // уведомление о конце победы
    func displayAlert() {
        let dialogMessage = UIAlertController(title: "Конец игры", message: "Победа!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    func displayLeaveGame() {
        let dialogMessage = UIAlertController(title: "Вы действительно хотите в меню?", message: "Игра не будет сохранена", preferredStyle: .alert)

        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            self.trueBack()
            self.deleteRecord()
        })
        let notOK = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(notOK)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    @objc func displayPause() {
        timer.invalidate()
        let dialogMessage = UIAlertController(title: "Пауза", message: "Таймер приостановлен", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            self.continueTimer()
            self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    func continueTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: NSDate(), repeats: true)
    }
    
    func deleteRecord()
    {
        print("Delete record function called")
    }
    
}
