//
//  ViewController.swift
//  ViewLabs
//
//  Created by Erik Flores on 19/04/23.
//

import UIKit

class ViewController: UIViewController {
    let rootContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ShowCard", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    let buttonContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let rootView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let firstView: UIView = {
        let view = UIView()
        view.tag = 1
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let secondView: UIView = {
        let view = UIView()
        view.tag = 2
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    lazy var rootHeightAnchor = rootView.heightAnchor.constraint(equalToConstant: 100)
    var openCard: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        addRootContainer()
        addViews()
        addGestures()
    }
    
    func addRootContainer() {
        view.addSubview(rootContainer)
        NSLayoutConstraint.activate([
            rootContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rootContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rootContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func addViews() {
        rootContainer.addArrangedSubview(buttonContainer)
        
        rootContainer.addArrangedSubview(rootView)
        NSLayoutConstraint.activate([
            rootHeightAnchor
        ])
        
        rootView.addSubview(firstView)
        NSLayoutConstraint.activate([
            firstView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            firstView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            firstView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        rootView.insertSubview(secondView, belowSubview: firstView)
        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(equalTo: rootView.topAnchor),
            secondView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            secondView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        buttonContainer.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    func addGestures() {
        let firstTap = UITapGestureRecognizer()
        firstTap.numberOfTapsRequired = 1
        firstTap.addTarget(self, action: #selector(firstAction))
        
        let secondTap = UITapGestureRecognizer()
        secondTap.numberOfTapsRequired = 1
        secondTap.addTarget(self, action: #selector(secondAction))
        
        firstView.addGestureRecognizer(firstTap)
        secondView.addGestureRecognizer(secondTap)
        
    }

    @objc
    func firstAction(_ sender: AnyObject) {
        print("tap in first")
    }
    
    @objc
    func secondAction(_ sender: AnyObject) {
        print("tap in second")
    }
    
    @objc
    func actionButton() {
        openCard.toggle()
        
        
        let animator = UIViewPropertyAnimator(duration: 0.7, dampingRatio: 0.5)
        animator.addAnimations {
            if self.openCard {
                self.secondView.alpha = 1
            } else {
                self.secondView.alpha = 0
            }
        }
        animator.addAnimations {
            if self.openCard {
                self.rootHeightAnchor.constant = 100
                self.secondView.transform = CGAffineTransform(translationX: 0, y: -100)
            } else {
                self.rootHeightAnchor.constant = -100
                self.secondView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
        }
        animator.startAnimation()
    }

}

