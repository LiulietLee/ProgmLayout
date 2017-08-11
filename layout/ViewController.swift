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
    fileprivate var cons = [NSLayoutConstraint]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
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
        }) { (isFinished) in
            if isFinished {
                self.fadeButton.alpha = 1.0
            }
        }
    }
    
    @objc fileprivate func move() {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [.autoreverse], animations: {
            self.moveButton.frame.origin.y += 100.0
        }) { (isFinished) in
            if isFinished {
                self.moveButton.frame.origin.y -= 100.0
            }
        }
    }
    
    fileprivate func configureConstraints() {
        let wfCon = fadeButton.widthAnchor.constraint(equalToConstant: 200.0)
        let hfCon = fadeButton.heightAnchor.constraint(equalToConstant: 100.0)
        
        let wmCon = NSLayoutConstraint(item: moveButton, attribute: .width, relatedBy: .equal, toItem: fadeButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        let hmCon = NSLayoutConstraint(item: moveButton, attribute: .height, relatedBy: .equal, toItem: fadeButton, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        if UIDevice.current.orientation.isPortrait || !UIDevice.current.orientation.isValidInterfaceOrientation {
            let xfCon = NSLayoutConstraint(item: fadeButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            let yfCon = NSLayoutConstraint(item: fadeButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: -80.0)
            
            let xmCon = NSLayoutConstraint(item: moveButton, attribute: .centerX, relatedBy: .equal, toItem: fadeButton, attribute: .centerX, multiplier: 1.0, constant: 0.0)
            let ymCon = NSLayoutConstraint(item: moveButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 80.0)
            
            cons = [xfCon, yfCon, wfCon, hfCon, xmCon, ymCon, wmCon, hmCon]
        } else {
            let xfCon = NSLayoutConstraint(item: fadeButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: -150.0)
            let yfCon = NSLayoutConstraint(item: fadeButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            
            let xmCon = NSLayoutConstraint(item: moveButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 150.0)
            let ymCon = NSLayoutConstraint(item: moveButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
            
            cons = [xfCon, yfCon, wfCon, hfCon, xmCon, ymCon, wmCon, hmCon]
        }
        
        NSLayoutConstraint.activate(cons)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        NSLayoutConstraint.deactivate(cons)
        configureConstraints()
    }

}

