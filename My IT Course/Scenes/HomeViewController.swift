//
//  HomeViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 28/03/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    var selectedCell: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewControllers = self.setupTabs()
    }
    
    func setupTabs() -> [UIViewController] {
        
        let programmesViewController = ProgrammesViewController()
        let programmesTabViewController = UINavigationController(rootViewController: programmesViewController)
        programmesTabViewController.navigationBar.isOpaque = true
        programmesTabViewController.navigationBar.isHidden = false
        programmesTabViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let selectedViewController = ProgrammesStatusViewController()
        let selectedProgrammesTabViewController = UINavigationController(rootViewController: selectedViewController)
        selectedProgrammesTabViewController.navigationBar.isOpaque = true
        selectedProgrammesTabViewController.navigationBar.isHidden = false
        selectedProgrammesTabViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return [programmesTabViewController, selectedProgrammesTabViewController]
    }
    
}
