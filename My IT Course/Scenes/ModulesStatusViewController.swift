//
//  ModulesStatusViewController.swift
//  My IT Course
//
//  Created by Pat Dynek on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ModulesStatusViewController: GenericTableViewController {

    var data: ([ProgrammeItem], ProgrammeItem)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionTitles = ["Module progress"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDataSource()
        // Reload table in case something changed between tables and tabs
        self.setupTable()
        self.tableView.reloadData()
    }
    
    private func setupDataSource() {
        self.dataSource = GenericDataSource(items: data.1.modules,
                                            reuseIdentifier: GenericTableViewController.detailsCell) { (module, @objc  cell) in
                                                cell.textLabel?.text = module.name
                                                
                                                if module.units.allSatisfy({ $0.status == .completed }) {
                                                    cell.detailTextLabel?.text = ModuleStatus.completed.rawValue
                                                } else if module.units.allSatisfy({ $0.status == .notStarted }) {
                                                    cell.detailTextLabel?.text = ModuleStatus.notstarted.rawValue
                                                } else {
                                                    cell.detailTextLabel?.text = ModuleStatus.ongoing.rawValue
                                                }
        }
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let unitsStatusViewController = UnitsStatusViewController()
        unitsStatusViewController.data = (data.0, data.1, (self.dataSource as! GenericDataSource<ModuleItem>).items[indexPath.row])
        self.navigationController?.pushViewController(unitsStatusViewController, animated: true)
    }

}
