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
   /* @IBOutlet var textFiled: UITextField!
    var textFields = [[UITextField!]](repeating: [UITextField!](repeating: UITextField(frame: CGRect(x: 100, y: 100,
                                                 width: 200,
                                                 height: 60)), count: 9), count: 9)*/
    let minValue = 1
    let maxValue = 9
    lazy var valuesRange = minValue...maxValue
    var timer = Timer()
    var answer = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var gettingMatrix = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    
    private var layout : UICollectionViewFlowLayout {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let boundSize: CGSize = UIScreen.main.bounds.size
        layout.itemSize = CGSize(width: boundSize.width, height: 50)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        let label = UILabel()
        self.view.addSubview(label)
        label.pinCenter(to: view, 0)
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "SUDOKU"
        label.textColor = .white
     //   let menu = MenuViewController.init()
    //    self.present(menu, animated: true)
      //  self.navigationController?.pushViewController(menu, animated: true)
      //  setUpMenu()
            // setUpMenuButton()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let menu = MenuViewController()
        menu.modalPresentationStyle = .fullScreen
        present(menu, animated: false, completion: nil)
    }
    func setUpMenuButton() {
        let actionHint = UIAction(title: "Hint") { action in
              print("action share clicked")
          }
          let actionSolution = UIAction(title: "Solution") { action in
              print("action add clicked")
              
          }
          let actionMistakes = UIAction(title: "Mistakes") { action in
              print("action edit clicked")
              
          }
        let button = UIButton()
        
        
     //   button.setTitle("", for: <#T##UIControl.State#>)
        button.addTarget(self, action: #selector(mmmm), for: .touchUpInside)
        button.setTitle("111", for: .normal)
        view.addSubview(button)
        button.pinCenter(to: view)
       // button.menu = menu1
        button.setTitleColor(.systemBlue, for: .normal)
       //   navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, primaryAction: nil, menu: menu)
    }
    
    @objc func mmmm() {
        let dialogMessage = UIAlertController(title: "Help", message: "You can get a hint, check your mistakes or discover our solution", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Mistakes", style: .default, handler: { (action) -> Void in
            self.findMistakes()
            self.deleteRecord()
        })
        let ok1 = UIAlertAction(title: "Hint", style: .default, handler: { (action) -> Void in
            self.hint()
            self.deleteRecord()
        })
        let ok2 = UIAlertAction(title: "Solution", style: .default, handler: { (action) -> Void in
            self.checker()
            self.deleteRecord()
        })
        let ok3 = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void in
            self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(ok1)
        dialogMessage.addAction(ok2)
        dialogMessage.addAction(ok3)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    // меню выбора уровня
    func setUpMenu () {
     //   self.navigationItem.backBarButtonItem
        let title = UILabel()
        title.text = "Select level"
        title.textColor = .systemBlue
        title.font = .boldSystemFont(ofSize: 28)
        title.textColor = .systemBlue
        view.addSubview(title)
     //   title.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 80)
        let screen = UIStackView()
        let menuStack = UIStackView()
    //    menuStack.alignment = .fille
     //   let menuStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 20, height: 100))
        menuStack.axis = .vertical
// menuStack.distribution = .fill
        menuStack.spacing = 30
        menuStack.addArrangedSubview(createMenuButton(name: "Easy"))
        menuStack.addArrangedSubview(createMenuButton(name: "Medium"))
        menuStack.addArrangedSubview(createMenuButton(name: "Hard"))
        menuStack.addArrangedSubview(createCustomGameButton())
        view.addSubview(menuStack)
     //   setMenuConstraints(menu: menuStack)
      //  screen.addArrangedSubview(title)
        screen.addArrangedSubview(menuStack)
        screen.axis = .vertical
        screen.spacing = 50
        view.addSubview(screen)
     //   title.center.x = view.center.x
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      //  title.textAlignment = .center
        title.pinTop(to: menuStack.topAnchor, -80)
      //  title.pinTop(to: menuStack)
       // title.setWidth(to: 80)
        //title.pin
       // title.pinCenter(to: menuStack)
        screen.pinCenter(to: view)
        menuStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
      //  view.pinCenter(to: screen)
     //   title.pinCenter(to: menuStack)
    //    title.pinCenter(to: menuStack.topAnchor)
      //  title.textAlignment = .center
     //   title.pinCenter(to: menuStack)
    }
    
    func createCustomGameButton() -> UIButton {
        let button = UIButton()
        button.configuration = .filled()
     //  button.configuration?.baseBackgroundColor = .white
        button.configuration?.cornerStyle = .small
        button.configuration?.titleAlignment = .center
        button.configuration?.buttonSize = .large
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
        button.setTitle("Custom game", for: .normal)
        button.addTarget(self, action: #selector(uploadGame), for: .touchUpInside)
        return button
    }
    
    @objc func uploadGame() {
        let myView = self.view
        if let myView = myView {
            for subview in myView.subviews {
                subview.removeFromSuperview()
            }
        }
        self.view.addSubview(timerLabel)
        timerLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 0
        zeroButton.setTitle("", for: .normal)
        currButton = zeroButton
        configureSudoku()
      //  configureStackView()
        configureBackButton()
        configureCustomKeyboard()
     //   configureKeyboard()
        //let generator = SudokuGenerator()
            // let result = generator.getSudokuWithGaps(level: self.level)
     //   let sudokuGrid = result.question
       // answer = generator.getAnswer()
        // расставляем циферки
       /* for i in 0..<9 {
            for j in 0..<9 {
              //  let name = String(sudokuGrid[i][j]) == "0" ? "" : String(sudokuGrid[i][j])
                if (name != "") {
                    buttons[9 * i + j].isEnabled = false
                    buttons[9 * i + j].setTitleColor(.black, for:.normal)
                }
                buttons[9 * i + j].setTitle(name, for: .normal)
            }
        }*/
        color()
     //   configureSudoku()
     //   for _ in 1...9 {
     //   @IBOutlet var textFiled = UITextField(frame: CGRect(x: 100,
     /*                                             y: 100,
                                                  width: 200,
                                                  height: 60))
            for i in textFields {
                self.i.delegate
            }
        self.textFiled.delegate = self
        textFiled.layer.borderWidth = 1
        textFiled.layer.borderColor = UIColor.systemBlue.withAlphaComponent(0.4).cgColor
        textFiled.setWidth(to: 40)
            textFiled.setHeight(to: 40)
        textFiled.font = .boldSystemFont(ofSize: 18)
        stack.addArrangedSubview(textFiled)
        }
        view.addSubview(stack)
        stack.pinCenter(to: view)*/
        
         //       textFiled.backgroundColor = .red
              //  textFiled.borderStyle = UITextBorderStyle.Line
         //       self.view.addSubview(textFiled)
        //textFiled.layer.borderWidth = 1
        //textFiled.layer.borderColor = UIColor.black.cgColor
    //    btn.layer.borderColor = UIColor.black.cgColor
   /*                let button = UIButton(frame: CGRect(x: 100,
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
    btn.layer.borderWidth = 1
        btn.setTitle(name, for: .normal)
        btn.setTitleColor(.systemBlue,
                                     for: .normal)
        btn.layer.borderWidth = 0
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)*/
  //      textFiled.pinCenter(to: view)
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
    //    button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        button.configuration = .filled()
        button.configuration?.cornerStyle = .small
        button.configuration?.titleAlignment = .center
        button.configuration?.buttonSize = .large
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle(name, for: .normal)
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
 //       button.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 20)
    //    button.pinRight(to: view.safeAreaLayoutGuide.rightAnchor, 20)
     /*   button.layer.cornerRadius = 20
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle(name, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false*/
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
        menu.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
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
        
        let label = UILabel()
        self.view.addSubview(label)
    //    label.textAlignment = .center;
       // label.pinCenter(to: view.safeAreaLayoutGuide.topAnchor)
        //label.pinCenter(to: v)
        label.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 20)
        label.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
     //   label.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 180)
     //   label.font = label.font.withSize(18)
        label.font = .boldSystemFont(ofSize: 18)
        timerLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 20)
     //   timerLabel.pinTop(to: gridStack, 20)
       // timerLabel.pinBottom(to: label, -40)
      //  timerLabel.pinCenter(to: view.centerXAnchor, 0)
     //   timerLabel.pinCenter(to: label, 20)
     //   timerLabel.pinLeft(to: label, 20)
     //   label.textColor =
        
    //    label.setTitleColor(.systemBlue,
     //                                for: .normal)
       // label.layer.borderWidth = 0
     //   label.titleLabel?.font = .boldSystemFont(ofSize: 18)
        switch level {
            case "1":
                label.text = "Level: Easy"
            case "2":
                label.text = "Level: Medium"
            case "3":
                label.text = "Level: Hard"
            default:break
        }
       //     label.textAlignment = .center
       // timerLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        zeroButton.setTitle("", for: .normal)
        currButton = zeroButton
        configureStackView()
        configureBackButton()
        configureKeyboard()
        
        timerLabel.pinTop(to: gridStack, -30)
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
    func setUpСustomGameView() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: NSDate(), repeats: true)
        
        self.view.addSubview(timerLabel)
        
        let label = UILabel()
        self.view.addSubview(label)
    //    label.textAlignment = .center;
       // label.pinCenter(to: view.safeAreaLayoutGuide.topAnchor)
        //label.pinCenter(to: v)
        label.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        label.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 180)
     //   label.font = label.font.withSize(18)
        label.font = .boldSystemFont(ofSize: 18)
        timerLabel.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 20)
     //   timerLabel.pinTop(to: gridStack, 20)
       // timerLabel.pinBottom(to: label, -40)
      //  timerLabel.pinCenter(to: view.centerXAnchor, 0)
     //   timerLabel.pinCenter(to: label, 20)
     //   timerLabel.pinLeft(to: label, 20)
     //   label.textColor =
        
    //    label.setTitleColor(.systemBlue,
     //                                for: .normal)
       // label.layer.borderWidth = 0
     //   label.titleLabel?.font = .boldSystemFont(ofSize: 18)
        label.text = "Custom"
       //     label.textAlignment = .center
       // timerLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        zeroButton.setTitle("", for: .normal)
        currButton = zeroButton
        configureStackView()
        configureBackButton()
        configureKeyboard()
        timerLabel.pinTop(to: gridStack, -30)
       // let generator = SudokuGenerator()
       // let result = generator.getSudokuWithGaps(level: self.level)
        let sudokuGrid = gettingMatrix
      //  let solver = SudokuSolver(gettin)
     //   solver.setMatrix(matrix: gettingMatrix)
      //  answer = solver.solveSudoku()
        
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
        let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitle("I need help", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(mmmm), for: .touchUpInside)
       /* let mistakesButton = createGameButton(name: "Мои ошибки")
        mistakesButton.addTarget(self, action: #selector(findMistakes), for: .touchUpInside)
        
        let hintsButton = createGameButton(name: "Подсказка")
        hintsButton.addTarget(self, action: #selector(hint), for: .touchUpInside)
        
        let answersButton = createGameButton(name: "Решение")
        answersButton.addTarget(self, action: #selector(checker), for: .touchUpInside)
        */
        let pauseButton = createGameButton(name: "Stop")
        pauseButton.backgroundColor = .systemBlue
        pauseButton.addTarget(self, action: #selector(displayPause), for: .touchUpInside)
        view.addSubview(pauseButton)
        pauseButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 20)
        pauseButton.pinTop(to: gridStack, -70)
        view.addSubview(button)
        button.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 20)
        button.pinTop(to: gridStack, -35)
        
        //buttonStack.addArrangedSubview(button)
        
      /*  buttonStack.addArrangedSubview(answersButton)
        buttonStack.addArrangedSubview(mistakesButton)
        buttonStack.addArrangedSubview(hintsButton)*/
        
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
    func configureCustomKeyboard() {
        view.addSubview(keyboardStack)
        keyboardStack.axis = .vertical
        keyboardStack.distribution = .fillEqually
        keyboardStack.spacing = 10
        addCustomKeyboardButtons()
        setKeyboardConstraints()
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
    func createPlayButton() -> UIButton {
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
            print(c)
        }
       // solver.setMatrix(gettingMatrix: myMatrix)
        let solver = SudokuSolver(matrix: gettingMatrix)
      /*  for i in 0..<9 {
            for j in 0..<9 {
                print(gettingMatrix[i][j])
            }
            print("\n")
        }*/
        solver.setMatrix(matrix: gettingMatrix)
        var check = 0
        solver.countSolutions(number: &check)

        if (check > 1) {
            let dialogMessage = UIAlertController(title: "Not valid", message: "Sudoku must have only one solution", preferredStyle: .alert)

            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                self.deleteRecord()
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        if (check == 0) {
            let dialogMessage = UIAlertController(title: "Not valid", message: "Sudoku must have a solution", preferredStyle: .alert)

            let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
                self.deleteRecord()
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
          //  let myView = self.view
            for view1 in self.view.subviews{
                view1.removeFromSuperview()
            }
         //   if let myView = myView {
        //        for subview in myView.subviews {
         //           subview.removeFromSuperview()
         //       }
          //  }
            buttons = []
           setUpСustomGameView()
        }
       // timerLabel.text = String(check)
     //   timerLabel.pinTop(to: gridStack, 10)
       /* let solver = SudokuSolver(matrix: myMatrix)
        solver.setMatrix(matrix: myMatrix)
        var check = 0
        solver.countSolutions(number: &check)
        var hardness = 81
        var positions: [Int] = []
        for i in 0..<81 {
            positions.append(i)
        }
        positions.shuffle()
        for i in 0..<81 {
            let x = positions[i] / 9;
            let y = positions[i] % 9
            if myArray[x][y] == 0 {
                myArray[x][y] = 1
                let temp = myMatrix[x][y]
                myMatrix[x][y] = 0
                hardness -= 1
                solver.setMatrix(matrix: myMatrix)
                var check = 0
                solver.countSolutions(number: &check)*/
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
       // gridStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -700).isActive = true
    }
    
    
    // уведомление о конце победы
    func displayAlert() {
        let dialogMessage = UIAlertController(title: "The game is over!", message: "All cells are filled correctly", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Stay here", style: .default, handler: { (action) -> Void in
            self.deleteRecord()
        })
        let ok2 = UIAlertAction(title: "Go to menu", style: .default, handler: { (action) -> Void in
            self.trueBack()
            self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        dialogMessage.addAction(ok2)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    func displayLeaveGame() {
        let dialogMessage = UIAlertController(title: "You are going to leave the game", message: "All changes won't be saved", preferredStyle: .alert)

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
        print("Clicked")
        let dialogMessage = UIAlertController(title: "Пауза", message: "Таймер приостановлен", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Continue", style: .default, handler: { (action) -> Void in
            self.continueTimer()
            self.deleteRecord()
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    func continueTimer() {
      //  timer.fire()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeUpdate), userInfo: NSDate(), repeats: true)
    }
    
    func deleteRecord()
    {
        print("Delete record function called")
    }
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= textField.maxLength
    }*/
    
}

extension ViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
    
    if newText.isEmpty {
      return true
    }
    
    return valuesRange.contains(Int(newText) ?? minValue - 1)
  }
}

/*extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            if let maxLength = self.maxLength {
                return maxLength
            } else {
                return Int.max
            }
        }
        set {
            self.maxLength = newValue
            addTarget(self, action: #selector(limitLength), for: .editingChanged)
        }
    }

    @objc func limitLength(textField: UITextField) {
        guard let text = textField.text else { return }
        textField.text = String(text.prefix(maxLength))
    }
}
 */

