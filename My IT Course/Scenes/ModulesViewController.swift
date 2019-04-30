//
//  ModulesViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 29/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ModulesViewController: GenericTableViewController {
    
    var programme: ProgrammeItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
        self.setupTable()
        self.sectionTitles = ["Modules in \(programme.name)"]
    }
    
    private func setupDataSource() {
        self.dataSource = GenericDataSource(items: programme.modules,
                                            reuseIdentifier: GenericTableViewController.accessoryCell) { (module, @objc  cell) in
                                                cell.textLabel?.text = module.name
        }
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let moduleDetailsViewController = ModuleDetailsViewController()
        moduleDetailsViewController.module = (self.dataSource as! GenericDataSource<ModuleItem>).items[indexPath.row]
        self.navigationController?.pushViewController(moduleDetailsViewController, animated: true)
    }

}
