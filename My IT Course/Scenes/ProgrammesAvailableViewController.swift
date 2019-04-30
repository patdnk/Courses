//
//  ProgrammesAvailableTableViewController.swift
//  My IT Course
//
//  Created by Pat Dynek on 29/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ProgrammesAvailableViewController: GenericTableViewController, AccessoryCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
        self.setupTable()
        self.sectionTitles = ["Programmes Available"]
    }
    
    private func setupDataSource() {
        self.dataSource = GenericDataSource(items: DataManager.shared.programmes,
                                            reuseIdentifier: ReusableTableViewController.accessoryCell) { (programme, @objc  cell) in
                                                cell.textLabel?.text = programme.name
                                                if programme.available {
                                                    cell.accessoryType = .checkmark
                                                } else {
                                                    cell.accessoryType = .none
                                                }
                                                (cell as! AccessoryCell).delegate = self
                                                
        }
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modulesViewController = ModulesAvailableViewController()
        modulesViewController.programme = (self.dataSource as! GenericDataSource<ProgrammeItem>).items[indexPath.row]
        self.navigationController?.pushViewController(modulesViewController, animated: true)
    }
    
    //MARK: - Accessory Cell delegate
    
    func didTapActionButton(selected: Bool, sender: UIButton) {
        let tapPoint = self.tableView.convert(sender.bounds.origin, from: sender)
        let indexPath = self.tableView.indexPathForRow(at: tapPoint)
        var selectedItem = (self.dataSource as! GenericDataSource<ProgrammeItem>).items[indexPath?.row ?? -1]
        selectedItem.available = selected
        if let index = (self.dataSource as! GenericDataSource<ProgrammeItem>).items.firstIndex(of: selectedItem) {
            (self.dataSource as! GenericDataSource<ProgrammeItem>).items.remove(at: index)
            (self.dataSource as! GenericDataSource<ProgrammeItem>).items.insert(selectedItem, at: index)
        }
        
        // if user deselects previously selected programme - present alert to show the potential implications of the unchecking the programme
        if !selected {
            let alert = UIAlertController(title: "Warning!", message: "Do you really want to make this programme not available?\nThis will remove it from the progress list!", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            
            let okAction = UIAlertAction(title: "OK", style: .destructive , handler:  { action in
                DataManager.shared.saveData((self.dataSource as! GenericDataSource<ProgrammeItem>).items)
            })
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            DataManager.shared.saveData((self.dataSource as! GenericDataSource<ProgrammeItem>).items)
        }
        
        
    }
    
}
