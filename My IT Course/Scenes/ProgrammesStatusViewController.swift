//
//  ProgrammesStatusViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ProgrammesStatusViewController: GenericTableViewController {
    
    var availableProgrammes: [Programme] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sectionTitles = ["Programmes status"]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let available = DatabaseManager.shared.fetchProgrammes()?.filter({ $0.available == true }) {
            self.availableProgrammes = available
        }
        
        self.updateProgrammeStatus()
        
        self.setupDataSource()
        // Reload table in case something changed between tables and tabs
        self.setupTable()
        self.tableView.reloadData()
    }
    
    private func setupDataSource() {
        //find only available programmes
        
        self.dataSource = GenericDataSource(items: [self.availableProgrammes],
                                            reuseIdentifier: GenericTableViewController.detailsCell) { (programme, @objc cell) in
                                                cell.textLabel?.text = programme.name
                                                cell.detailTextLabel?.text = programme.status
//                                                cell.detailTextLabel?.text = programme.status == .none ? "" : programme.status.rawValue
//
//                                                if programme.modules.allSatisfy({ $0.status == .completed }) {
//                                                    cell.detailTextLabel?.text = ProgrammeStatus.certified.rawValue
//                                                }
//
//                                                if programme.modules.filter({  $0.status == .ongoing }).count > 0 {
//                                                    cell.detailTextLabel?.text = ProgrammeStatus.inProgress.rawValue
//                                                }
        }
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modulesStatusViewController = ModulesStatusViewController()
        modulesStatusViewController.modules = Array(self.availableProgrammes[indexPath.row].modules!)
        self.navigationController?.pushViewController(modulesStatusViewController, animated: true)
    }
    
    func updateProgrammeStatus() {
        for programme in self.availableProgrammes {
            for module in programme.modules! {
                
                programme.setValue("", forKey: "status")
                
                if module.status == "On going" || module.status == "Not started" {
                    programme.setValue("In progress", forKey: "status")
                }
                
                if programme.modules!.allSatisfy( { $0.status == "Completed" } ) {
                    programme.setValue("Certified", forKey: "status")
                }
                
                DatabaseManager.shared.saveContext()
            }
        }
    }

}
