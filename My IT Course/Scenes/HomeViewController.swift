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
        programmesTabViewController.tabBarItem = UITabBarItem(title: "Programmes", image: UIImage.init(named: "ic_programmes"), tag: 0)
        
        let selectedViewController = ProgrammesStatusViewController()
        let selectedProgrammesTabViewController = UINavigationController(rootViewController: selectedViewController)
        selectedProgrammesTabViewController.navigationBar.isOpaque = true
        selectedProgrammesTabViewController.navigationBar.isHidden = false
        selectedProgrammesTabViewController.tabBarItem = UITabBarItem(title: "Statuses", image: UIImage.init(named: "ic_statuses"), tag: 1)
        
        let examsListViewController = ExamsListViewController()
        let examsListTabViewController = UINavigationController(rootViewController: examsListViewController)
        examsListTabViewController.navigationBar.isOpaque = true
        examsListTabViewController.navigationBar.isHidden = false
        examsListTabViewController.tabBarItem = UITabBarItem(title: "Exams", image: UIImage.init(named: "ic_exams"), tag: 2)
        
        return [programmesTabViewController, selectedProgrammesTabViewController, examsListTabViewController]
    }
    
}
