//
//  ViewController.swift
//  SudokuApp
//
//  Created by Olga on 08.03.2023.
//

import UIKit


class ViewController: UIViewController {
    private let data: [[Int]] = [[1, 0, 0, 4, 5, 0, 7, 8, 9],
                                     [4, 5, 6, 0, 8, 9, 1, 2, 3],
                                     [0, 8, 9, 1, 2, 3, 4, 5, 6],
                                     [2, 3, 4, 5, 6, 7, 8, 9, 1],
                                     [5, 6, 7, 8, 9, 1, 2, 3, 4],
                                     [8, 9, 1, 2, 3, 4, 5, 6, 7],
                                     [3, 4, 5, 6, 7, 8, 9, 1, 2],
                                     [6, 7, 0, 9, 1, 2, 3, 4, 5],
                                     [9, 1, 2, 3, 4, 5, 6, 0, 8]]
    var stackView = UIStackView()
    var choiceStackView = UIStackView()
    //   var titleLabel = UILabel()
    var buttons = [UIButton]()
    var choiceButtons = [UIButton]()
    var choiceButtonchosen = UIButton()
    var zeroButton = UIButton()
    var buttonChosen = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  zeroButton.setTitle("", for: .normal)
       // choiceButtonchosen = zeroButton
     //   buttonChosen = zeroButton
        
        //     configureTitleLabel()
        configureChoiceStackView()
        configureStackView()
     //   Generation().getSudoku()

    }
    
    
    func configureChoiceStackView() {
        view.addSubview(choiceStackView)
        choiceStackView.axis = .horizontal
        choiceStackView.distribution = .fillEqually
        choiceStackView.spacing = 10
        choiceStackView.translatesAutoresizingMaskIntoConstraints = false
        choiceStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        choiceStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        choiceStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
        choiceStackView.heightAnchor.constraint(equalTo: choiceStackView.widthAnchor, multiplier: 1.0/10.0).isActive = true
        
        //   choiceStackView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -100).isActive = true
        for i in 1...9 {
            let button = UIButton(frame: CGRect(x: 100,
                                                y: 100,
                                                width: 200,
                                                height: 60))
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1.0/1.0).isActive = true
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.setTitleColor(.black, for: .normal)
            button.setTitle("\(i)",
                            for: .normal)
            button.setTitleColor(.systemBlue,
                                 for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(pressedChoice), for: .touchUpInside)
            choiceButtons.append(button)
            choiceStackView.addArrangedSubview(button)
        }
    }
    
    func addHorizontalStacks() {
        for _ in 1...9 {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            stack.spacing = 0
            stack.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
            addButtons(a: stack)
            stackView.addArrangedSubview(stack)
        }
    }
    
    func addButtons(a: UIStackView) {
        for i in 1...9 {
            let button = UIButton(frame: CGRect(x: 100,
                                                y: 100,
                                                width: 200,
                                                height: 60))
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.setTitleColor(.black, for: .normal)
            button.setTitle("\(i)",
                            for: .normal)
            button.setTitleColor(.systemBlue,
                                 for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            // button.addTarget(self, action: #selector(pressed), for: .touchCancel)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1.0/1.0).isActive = true
            buttons.append(button)
            a.addArrangedSubview(button)
        }
    }
    
    @objc func pressedChoice(sender: UIButton) {
            if (buttonChosen.title(for: .normal) != "") {
                buttonChosen.setTitle(sender.title(for: .normal) , for: .normal)
            }
    }
    
    @objc func pressed(sender: UIButton) {
        if (sender.layer.borderWidth == 2) {
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.borderWidth = 1
            buttonChosen = zeroButton
        } else {
            buttonChosen = sender
            if (choiceButtonchosen.title(for: .normal) != "") {
                sender.setTitle(choiceButtonchosen.title(for: .normal) , for: .normal)
                sender.layer.borderWidth = 1
                buttonChosen.layer.borderWidth = 1
                
            } else {
                sender.layer.borderWidth = 2
                for i in 0...buttons.count - 1{
                    if (buttons[i] != sender) {
                        buttons[i].layer.borderWidth = 1
                    }
                }
            }
        }
    }
    
    /*  func configureTitleLabel() {
     view.addSubview(titleLabel)
     titleLabel.text = "Help"
     titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
     titleLabel.textAlignment = .center
     titleLabel.numberOfLines = 0
     titleLabel.adjustsFontSizeToFitWidth = true
     setTitleLableConstraints()
     }
     func setTitleLableConstraints() {
     titleLabel.translatesAutoresizingMaskIntoConstraints = false
     titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
     titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
     titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
     }*/
    func configureStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        addHorizontalStacks()
        //   addButtons()
        setStackViewConstraints()
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: choiceStackView.bottomAnchor, constant: 120).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
    }
    
}

