//
//  ViewController.swift
//  layout
//
//  Created by Liuliet.Lee on 10/8/2017.
//  Copyright © 2017 Liuliet.Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let fadeButton = UIButton()
    fileprivate let moveButton = UIButton()
    
    fileprivate lazy var generalCons: [NSLayoutConstraint] = [
        self.fadeButton.widthAnchor.constraint(equalToConstant: 200.0),
        self.fadeButton.heightAnchor.constraint(equalToConstant: 100.0),
        self.moveButton.widthAnchor.constraint(equalTo: self.fadeButton.widthAnchor),
        self.moveButton.heightAnchor.constraint(equalTo: self.fadeButton.heightAnchor)
    ]
    
    fileprivate lazy var landscapeCons: [NSLayoutConstraint] = [
        self.fadeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -150.0),
        self.fadeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        self.moveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 150.0),
        self.moveButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ]
    
    fileprivate lazy var protraitCons: [NSLayoutConstraint] = [
        self.fadeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.fadeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80.0),
        self.moveButton.centerXAnchor.constraint(equalTo: self.fadeButton.centerXAnchor),
        self.moveButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 80.0)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        NSLayoutConstraint.activate(generalCons)
    }
    
    fileprivate func configureButtons() {
        configure(button: fadeButton, bColor: UIColor.darkGray, title: "fade", selector: #selector(fade))
        configure(button: moveButton, bColor: UIColor.orange, title: "move", selector: #selector(move))
        
        view.addSubview(fadeButton)
        view.addSubview(moveButton)
        
        configureConstraints()
    }

    fileprivate func configure(button: UIButton, bColor: UIColor, title: String, selector: Selector) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = bColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 36.0)
        button.layer.cornerRadius = 16.0
        button.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    @objc fileprivate func fade() {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.autoreverse], animations: {
            self.fadeButton.alpha = 0.0
        }) { isFinished in
            if isFinished {
                self.fadeButton.alpha = 1.0
            }
        }
    }
    
    @objc fileprivate func move() {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.autoreverse], animations: {
            self.moveButton.frame.origin.y += 100.0
        }) { isFinished in
            if isFinished {
                self.moveButton.frame.origin.y -= 100.0
            }
        }
    }
    
    fileprivate func configureConstraints() {
        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.deactivate(protraitCons)
            NSLayoutConstraint.activate(landscapeCons)
        } else {
            NSLayoutConstraint.deactivate(landscapeCons)
            NSLayoutConstraint.activate(protraitCons)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureConstraints()
    }

}

