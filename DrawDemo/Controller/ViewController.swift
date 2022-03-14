//
//  ViewController.swift
//  DrawDemo
//
//  Created by lsaac on 2022/3/14.
//

import UIKit





class ViewController: UIViewController {

    let canvas = Canvas()
    
    
    let undoButton :UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Undo", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return btn
    }()
    
    
    @objc func handleUndo(){
        canvas.undo()
    }
    
    let clearButton :UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Clear", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleClear(){
        canvas.clear()
    }
    
    
    let yellowButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blueButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let redButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc func handleColorChange(button:UIButton){
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    
    
    let slider: UISlider = {
       let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSlider(){
        canvas.setWidth(width: CGFloat(slider.value))
    }
    
    
    
    
    
    
    override func loadView() {
        self.view = canvas
    }
    
    
    
    fileprivate func setupLayout() {
        let colorsStackView = UIStackView(arrangedSubviews: [
            yellowButton,
            redButton,
            blueButton,
        ])
        colorsStackView.distribution = .fillEqually
        
        //        canvas.frame = view.frame
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton,
            colorsStackView,
            slider
        ])
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //        stackView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
//        view.addSubview(canvas)
        canvas.backgroundColor = .white
        setupLayout()
        
    }


}

