//
//  UserProfileViewController.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/3/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import UIKit

class MainPagationController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [UserProfileViewController(), MatchingViewController(), MessageLogTableViewController()]
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        let prevIndex = viewControllerIndex - 1
        guard prevIndex >= 0 else { return nil }
        guard orderedViewControllers.count > prevIndex else { return nil }
        
        return orderedViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard orderedViewControllers.count != nextIndex else { return nil }
        guard orderedViewControllers.count > nextIndex else { return nil }
    
        return orderedViewControllers[nextIndex]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if AuthLayer.shared.myUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginViewController()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        AuthLayer.shared.getUser()
        setupControllersForPage()
    }
    
    func setupControllersForPage() {
        self.delegate = self
        self.dataSource = self
        orderedViewControllers = [UserProfileViewController(), MatchingViewController(),MessageLogTableViewController()]
        
        let matchingVC = orderedViewControllers[1]
        self.setViewControllers([matchingVC], direction: .forward, animated: true, completion: nil)
    }

    
}

