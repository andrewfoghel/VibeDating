//
//  UserProfileViewController.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/4/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import UIKit

let offBlack = UIColor(white: 0.3, alpha: 0.5)

class UserProfileViewController: UIViewController {
   
    //Edit Info View Controller
    
    let mainImage = RoundImageView(color: .clear, cornerRadius: 10)
    let topRightSecondaryImage = RoundImageView(color: .clear, cornerRadius: 10)
    let midRightSecondaryImage = RoundImageView(color: .clear, cornerRadius: 10)
    let leftBottomSecondaryImage = RoundImageView(color: .clear, cornerRadius: 10)
    let midBottomSecondaryImage = RoundImageView(color: .clear, cornerRadius: 10)
    let rightBottomSecondaryImage = RoundImageView(color: .clear, cornerRadius: 10)
    
    let btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 100, y: 400, width: 50, height: 50))
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func handleLogout() {
        AuthLayer.shared.handleLogout {
            let loginVC = LoginViewController()
            let navController = UINavigationController(rootViewController: loginVC)
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    fileprivate func setupImageViews() {
        view.addSubview(mainImage)
        if let url = currentUser.profileImageUrl {
            mainImage.loadImage(urlString: url)
        }
        view.addSubview(topRightSecondaryImage)
        view.addSubview(midRightSecondaryImage)
        
        
        mainImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: nil, bottom: nil, paddingTop: 12, paddingLeft: 12, paddingRight: 0, paddingBottom: 0, width: 225, height: 225)
        topRightSecondaryImage.anchor(top: mainImage.topAnchor, left: mainImage.rightAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 24, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)
        midRightSecondaryImage.anchor(top: topRightSecondaryImage.bottomAnchor, left: topRightSecondaryImage.leftAnchor, right: nil, bottom: nil, paddingTop: 18, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 100, height: 100)

        lastRowOfImages()
        view.addSubview(btn)
    }
    
    fileprivate func lastRowOfImages() {
        let stackView = UIStackView(arrangedSubviews: [leftBottomSecondaryImage, midBottomSecondaryImage, rightBottomSecondaryImage])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        view.addSubview(stackView)
        stackView.anchor(top: mainImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 12, paddingLeft: 12, paddingRight: 12, paddingBottom: 0, width: 0, height: 100)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = offBlack
        
        
        setupImageViews()
        
    }
    
    
    
    
    
    
    //End edit info profile
}
