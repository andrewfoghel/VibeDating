//
//  SignUpViewController.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/3/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import UIKit
import Firebase

var currentUser = MyUser()

class SignUpViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "background")
        return iv
    }()
    
    let nameTextField = RoundedTextField(color: .white, font: UIFont(name: "Avenir Next", size: 14), cornerRadius: 10, placeHolder: "Name")
    let emailTextField = RoundedTextField(color: .white, font: UIFont(name: "Avenir Next", size: 14), cornerRadius: 10, placeHolder: "Email")
    let passwordTextField = RoundedTextField(color: .white, font: UIFont(name: "Avenir Next", size: 14), cornerRadius: 10, placeHolder: "Password")
    let confirmPasswordTextField = RoundedTextField(color: .white, font: UIFont(name: "Avenir Next", size: 14), cornerRadius: 10, placeHolder: "Confirm")
    
    let signupButton = LoginButton(color: .orange, textColor: .orange, title: "Sign Up", font: UIFont(name: "Avenir Next", size: 14), cornerRadius: 10)
    
    let loginButton = LoginButton(color: .lightGray, textColor: .lightGray, title: "Login", font: UIFont(name: "Avenir Next", size: 14), cornerRadius: 10)
    
    fileprivate func setupViews() {
        view.backgroundColor = .black
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 40, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddImage)))
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        setupTextFields()
        
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signupButton.anchor(top: confirmPasswordTextField.bottomAnchor, left: nil, right: confirmPasswordTextField.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 75, height: 40)
        
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginButton.anchor(top: signupButton.topAnchor, left: confirmPasswordTextField.leftAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 75, height: 40)
    }
    
    @objc fileprivate func handleAddImage(gesture: UITapGestureRecognizer) {
        let photoSelector = PhotoSelectorController()
        let navController = UINavigationController(rootViewController: photoSelector)
        present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSignUp() {
   //     guard let profileImage = profileImageView.image else { return }
        guard let name = nameTextField.text, name != "" else { print("A"); return } //Perhaps check with regex
        guard let email = emailTextField.text, email != "" else { print("B"); return } //Perhaps check with regex
        guard let password = passwordTextField.text, password != "", let confirmedPassword = confirmPasswordTextField.text, confirmedPassword != "", confirmedPassword == password else {
            print("C");
            return
        }
        
        
        AuthLayer.shared.createUser(email: email, password: password, name: name, image: profileImageView.image!) { (success) in
            if success {
                guard let mainPaginationController = UIApplication.shared.keyWindow?.rootViewController as? MainPagationController else { return }
                mainPaginationController.setupControllersForPage()
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Unable to save user")
            }
        }
    }
    
    @objc fileprivate func handleLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    fileprivate func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 200)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
