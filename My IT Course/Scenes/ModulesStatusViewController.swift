//
//  ModulesStatusViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ModulesStatusViewController: GenericTableViewController {

    var modules: [Module] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionTitles = ["Module progress"]
        self.updateModuleStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDataSource()
        // Reload table in case something changed between tables and tabs
        self.setupTable()
        self.tableView.reloadData()
    }
    
    private func setupDataSource() {
        self.dataSource = GenericDataSource(items: [modules],
                                            reuseIdentifier: GenericTableViewController.detailsCell) { (module, @objc  cell) in
                                                cell.textLabel?.text = module.name
                                                cell.detailTextLabel?.text = module.status
        }
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let unitsStatusViewController = UnitsStatusViewController()
        unitsStatusViewController.units = Array(self.modules[indexPath.row].units!).sorted(by: { $0.name! < $1.name! })
        unitsStatusViewController.moduleName = self.modules[indexPath.row].name!
//        unitsStatusViewController.data = (data.0, data.1, (self.dataSource as! GenericDataSource<Module>).items[indexPath.row])
        self.navigationController?.pushViewController(unitsStatusViewController, animated: true)
    }
    
    func updateModuleStatus() {
        for module in self.modules {
            for unit in module.units! {
                if unit.status == "Currently studying" {
                    module.setValue("On going", forKey: "status")
                }
                
                if module.units!.allSatisfy( { $0.status == "Not started" } ) {
                    module.setValue("Not started", forKey: "status")
                }
                
                if module.units!.allSatisfy( { $0.status == "Completed" } ) {
                    module.setValue("Completed", forKey: "status")
                }
                
                DatabaseManager.shared.saveContext()
            }
        }
    }

}
