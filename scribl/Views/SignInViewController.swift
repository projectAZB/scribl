//
//  SignInViewController.swift
//  scribl
//
//  Created by Adam Bollard on 8/19/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: BaseViewController {
    
    let fieldWidth: CGFloat = 240.0
    let fieldHeight: CGFloat = 44.0
    let buttonWidth: CGFloat = 80.0
    let buttonHeight: CGFloat = 32.0
    let font: UIFont = UIFont(name: "Helvetica-Light", size: 14.0)!
    
    private lazy var emailField: UITextField = {
        let emailField = UITextField()
        emailField.font = font
        emailField.textContentType = .emailAddress
        emailField.placeholder = "email"
        emailField.textColor = .pureBlack()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        return emailField
    }()
    
    private lazy var passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.font = font
        passwordField.textContentType = .password
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "password"
        passwordField.textColor = .pureBlack()
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        return passwordField
    }()
    
    private lazy var createButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("Create", for: .normal)
        createButton.addTarget(self, action: #selector(onCreatePressed), for: .touchUpInside)
        applyBorder(view: createButton)
        styleButton(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        return createButton
    }()
    
    @objc func onCreatePressed() {
        if let emailText = emailField.text, emailText.count > 5,
            let passwordText = passwordField.text, passwordText.count >= 6 {
            UserManager.shared.createUser(email: emailText, password: passwordText) { (success, errorMessage) in
                guard success else {
                    print("Error: \(errorMessage!)")
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(onSignInPressed), for: .touchUpInside)
        applyBorder(view: signInButton)
        styleButton(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        return signInButton
    }()
    
    @objc func onSignInPressed() {
        if let emailText = emailField.text, emailText.count > 5,
            let passwordText = passwordField.text, passwordText.count >= 6 {
            UserManager.shared.signIn(email: emailText, password: passwordText) { (success, errorMessage) in
                guard success else {
                    print("Error: \(errorMessage!)")
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func configureUI() {
        isModalInPresentation = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        view.addGestureRecognizer(tapGesture)
        
        view.backgroundColor = .pureWhite()
        
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(createButton)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate(
            [
                emailField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Dimensions.margin128),
                emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emailField.widthAnchor.constraint(equalToConstant: fieldWidth),
                emailField.heightAnchor.constraint(equalToConstant: fieldHeight),
                
                passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: Dimensions.margin16),
                passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordField.widthAnchor.constraint(equalToConstant: fieldWidth),
                passwordField.heightAnchor.constraint(equalToConstant: fieldHeight),
                
                createButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: Dimensions.margin32),
                createButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: Dimensions.margin16),
                createButton.widthAnchor.constraint(equalToConstant: buttonWidth),
                createButton.heightAnchor.constraint(equalToConstant: buttonHeight),
                
                
                signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: Dimensions.margin32),
                signInButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -Dimensions.margin16),
                signInButton.widthAnchor.constraint(equalToConstant: buttonWidth),
                signInButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            ]
        )
    }
    
    @objc func onViewTapped() {
        if emailField.isFirstResponder {
            emailField.resignFirstResponder()
        }
        if passwordField.isFirstResponder {
            passwordField.resignFirstResponder()
        }
    }
    
    private func styleButton(_ button: UIButton) {
        button.setTitleColor(.pureBlack(), for: .normal)
        button.titleLabel?.font = font
    }
    
    private func applyBorder(view: UIView) {
        view.layer.borderColor = UIColor.pureBlack().cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 2.0
    }
    
}
