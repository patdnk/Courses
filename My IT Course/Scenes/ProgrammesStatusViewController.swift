//
//  ProgrammesStatusViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ProgrammesStatusViewController: GenericTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionTitles = ["Programmes status"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupDataSource()
        // Reload table in case something changed between tables and tabs
        self.setupTable()
        self.tableView.reloadData()
    }
    
    private func setupDataSource() {
        //find only available programmes
        
        var availableProgrammes = DataManager.shared.programmes.filter { $0.available == true }
        
        self.dataSource = GenericDataSource(items: availableProgrammes,
                                            reuseIdentifier: GenericTableViewController.detailsCell) { (programme, @objc cell) in
                                                cell.textLabel?.text = programme.name
                                                cell.detailTextLabel?.text = programme.status == .none ? "" : programme.status.rawValue
                                                
                                                if programme.modules.allSatisfy({ $0.status == .completed }) {
                                                    cell.detailTextLabel?.text = ProgrammeStatus.certified.rawValue
                                                }
                                                
                                                if programme.modules.filter({  $0.status == .ongoing }).count > 0 {
                                                    cell.detailTextLabel?.text = ProgrammeStatus.inProgress.rawValue
                                                }
        }
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modulesStatusViewController = ModulesStatusViewController()
        modulesStatusViewController.data = (DataManager.shared.programmes, (self.dataSource as! GenericDataSource<ProgrammeItem>).items[indexPath.row])
        self.navigationController?.pushViewController(modulesStatusViewController, animated: true)
    }

}
