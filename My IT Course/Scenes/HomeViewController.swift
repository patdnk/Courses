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
        
        let programmesAvailableTableViewController = ProgrammesAvailableViewController()
        
//        let programmesDataSource = GenericDataSource(items: DataManager.shared.programmes,
//                                                               reuseIdentifier: ReusableTableViewController.accessoryCell) { (programme,@objc  cell) in
//                                                                cell.textLabel?.text = programme.name
////                                                                (cell.accessoryView as! UIButton).addTarget(programmeAvailableViewController, action: #selector(programmeAvailableViewController.accessoryTapped(_:)), for: .touchUpInside)
////                                                                (cell as! AccessoryCell).textLabel?.text = programme.name
//                                                                    (cell as! AccessoryCell).actionButton.layer.borderWidth = 2
//                                                                    (cell as! AccessoryCell).actionButton.layer.borderColor = UIColor.green.cgColor
//                                                                
//                                                                (cell as! AccessoryCell).delegate = programmesAvailableTableViewController
//                                                                
//                                                                //                                            cell.accessoryView = self.createAccessorySwitchButton(for: cell)
//                                                                //                                            if (cell.contentView.subviews.filter { $0 is AccessoryButton }).first == nil {
//                                                                //                                                cell.contentView.addSubview(self.createAccessorySwitchButton(for: cell))
//                                                                //                                            }
//        }
//        
//        programmesAvailableTableViewController.dataSource = programmesDataSource
//        programmesAvailableTableViewController.sectionTitles = ["Programmes Available"]
//        programmesAvailableTableViewController.title = "Available programmes"
        let availableTabViewController = UINavigationController(rootViewController: programmesAvailableTableViewController)
        availableTabViewController.navigationBar.isOpaque = true
        availableTabViewController.navigationBar.isHidden = false
        availableTabViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        
        
//        let tableConfig = TableConfiguration.init(sectionsTitles: ["Programmes Available"], mode: .detail, level: 0, accessoryAction: nil)
        
//        let anotherVC = ConfigurableTableViewController(items: DataManager.shared.programmes, configure: { (cell: UITableViewCell, programme) in
//            cell.textLabel?.text = programme.name
//        }, selectHandler: {  (programme) in
//
//            let modulesTableConfig = TableConfiguration.init(sectionsTitles: ["Modules Available"], mode: .detail, level: 0, accessoryAction: nil)
//
//            let createLevel2Table = ConfigurableTableViewController(items: programme.modules, configure: { (cell: UITableViewCell, module) in
//                cell.textLabel?.text = module.name
//            }, selectHandler: { (module) in
//                print(module.description)
//            }, configuration: modulesTableConfig)
//
//            (anotherVC as! ConfigurableTableViewControllerProtocol).present(createLevel2Table, animated: true)
//
//
//        }, configuration: tableConfig)
//        let anotherTabViewController = UINavigationController(rootViewController: anotherVC)
//        anotherTabViewController.navigationBar.isOpaque = true
//        anotherTabViewController.navigationBar.isHidden = false
//        anotherTabViewController.tabBarItem = UITabBarItem(title: "Another", image: nil, tag: 0)
        
        
        
        return [availableTabViewController]
    }
    
//    func createAccessorySwitchButton(for cell: UITableViewCell) -> UIButton {
//        let accessoryButton = AccessoryButton(frame: CGRect(origin: CGPoint(x: self.view.bounds.width - 36, y: (cell.frame.height - 24) / 2 ), size: CGSize(width: 24, height: 24)))
//        accessoryButton.backgroundColor = .clear
//        accessoryButton.cell = cell
//        accessoryButton.backgroundColor = UIColor.darkText
//        accessoryButton.layer.borderColor = UIColor.green.cgColor
//        accessoryButton.layer.borderWidth = 2
//        accessoryButton.addTarget(self, action: #selector(toggleProgrammeCheck(_:)), for: .touchUpInside)
//        return accessoryButton
//    }
    
//    @objc func toggleProgrammeCheck(_ sender: Any) {
//        let button = sender as! AccessoryButton
//        let cell = button.cell
//        (cell as! AccessoryCell).toggleAccessory()
//    }

}
