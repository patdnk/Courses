//
//  ModulesViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 29/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ModulesViewController: GenericTableViewController {
    
    var modules: [Module] = []
    var programmeName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
        self.setupTable()
        self.sectionTitles = ["Modules in \(programmeName)"]
    }
    
    private func setupDataSource() {
        self.dataSource = GenericDataSource(items: [modules],
                                            reuseIdentifier: GenericTableViewController.accessoryCell) { (module, @objc  cell) in
                                                cell.textLabel?.text = module.name
        }
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moduleDetailsViewController = ModuleDetailsViewController()
        moduleDetailsViewController.module = self.modules[indexPath.row]
        self.navigationController?.pushViewController(moduleDetailsViewController, animated: true)
    }

}
