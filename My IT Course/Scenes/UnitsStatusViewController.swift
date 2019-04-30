//
//  UnitsStatusViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class UnitsStatusViewController: GenericTableViewController, DetailsCellDelegate {

    var data: ([ProgrammeItem], ProgrammeItem, ModuleItem)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
        self.setupTable()
        self.sectionTitles = ["Units in \(data.2.name)"]
        self.tableView.allowsSelection = false
    }
    
    private func setupDataSource() {
        self.dataSource = GenericDataSource(items: data!.2.units,
                                            reuseIdentifier: GenericTableViewController.detailsCell) { (unit, @objc  cell) in
                                                cell.textLabel?.text = unit.name
                                                cell.detailTextLabel?.text = unit.status.rawValue
                                                (cell as! DetailsCell).delegate = self
        }
    }
    
    //MARK: - Details Cell delegate
    
    func didTapActionButton(sender: UIButton) {
        let tapPoint = self.tableView.convert(sender.bounds.origin, from: sender)
        let indexPath = self.tableView.indexPathForRow(at: tapPoint)
        var selectedItem = (self.dataSource as! GenericDataSource<UnitItem>).items[indexPath?.row ?? -1]
        
        let alert = UIAlertController(title: "Status", message: "Adjust the unit status", preferredStyle: .actionSheet)
        
        let notStartedAction = UIAlertAction.init(title: "Not started", style: .default) { (action) in
            self.adjustUnitStatus(item: &selectedItem, status: .notStarted)
        }
        alert.addAction(notStartedAction)
        
        let currentlyStudyingAction = UIAlertAction.init(title: "Currently studying", style: .default) { (action) in
            self.adjustUnitStatus(item: &selectedItem, status: .currentlyStudying)
        }
        alert.addAction(currentlyStudyingAction)
        
        let completedAction = UIAlertAction.init(title: "Completed", style: .default) { (action) in
            self.adjustUnitStatus(item: &selectedItem, status: .completed)
        }
        alert.addAction(completedAction)
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func adjustUnitStatus(item: inout UnitItem, status: UnitStatus) {
        item.status = status
        if let index = (self.dataSource as! GenericDataSource<UnitItem>).items.firstIndex(of: item) {
            (self.dataSource as! GenericDataSource<UnitItem>).items.remove(at: index)
            (self.dataSource as! GenericDataSource<UnitItem>).items.insert(item, at: index)
            data.2.units = (self.dataSource as! GenericDataSource<UnitItem>).items
            
            if let moduleIndex = data.1.modules.firstIndex(of: data.2) {
                data.1.modules.remove(at: moduleIndex)
                data.1.modules.insert(data.2, at: moduleIndex)
                
                if let programmeIndex = data.0.firstIndex(of: data.1) {
                    data.0.remove(at: programmeIndex)
                    data.0.insert(data.1, at: programmeIndex)
                    
                    DataManager.shared.saveData(data.0)
                    
                }
                
            }
            
        }
        
        // Reload table to show the updated status
        self.setupTable()
        self.tableView.reloadData()
    }

}
