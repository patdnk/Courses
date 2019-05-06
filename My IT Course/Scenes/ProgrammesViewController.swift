//
//  ProgrammesAvailableTableViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 29/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit
import CoreData

class ProgrammesViewController: GenericTableViewController, AccessoryCellDelegate {
    
    var programmes: [Programme] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.programmes = DatabaseManager.shared.fetchProgrammes()!.sorted(by: { $0.id < $1.id })
        self.setupDataSource()
        self.setupTable()
        self.sectionTitles = ["Programmes available"]
        
        
    }
    
    private func setupDataSource() {
        
        self.dataSource = GenericDataSource(items: [self.programmes],
                                            reuseIdentifier: GenericTableViewController.accessoryCell) { (programme, @objc  cell) in
                                                cell.textLabel?.text = programme.name
                                                if programme.available {
                                                    cell.accessoryType = .checkmark
                                                } else {
                                                    cell.accessoryType = .none
                                                }
                                                (cell as! AccessoryCell).delegate = self }
    
    }
    
    //MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedProgramme = self.programmes[indexPath.row]
        
        let modulesViewController = ModulesViewController()
        modulesViewController.programmeName = selectedProgramme.name!
        modulesViewController.modules = Array(selectedProgramme.modules!).sorted(by: { $0.id < $1.id })
        self.navigationController?.pushViewController(modulesViewController, animated: true)
        
    }
    
    //MARK: - Accessory Cell delegate
    
    func didTapActionButton(selected: Bool, sender: UIButton) {
        
        let tapPoint = self.tableView.convert(sender.bounds.origin, from: sender)
        let indexPath = self.tableView.indexPathForRow(at: tapPoint)
        let selectedItem = programmes[indexPath!.row] //(self.dataSource as! GenericDataSource<Programme>).items[indexPath?.row ?? -1]
        
        // if user deselects previously selected programme - present alert to show the potential implications of the unchecking the programme
        if selected {
            
            let alert = UIAlertController(title: "Warning!", message: "Do you really want to make this programme not available?\nThis will remove it from the progress list!", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            
            let okAction = UIAlertAction(title: "OK", style: .destructive , handler:  { action in
                self.update(selectedItem, selected: !selected)
                (self.tableView.cellForRow(at: indexPath!) as! AccessoryCell).toggleAccessory()
            })
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            self.update(selectedItem, selected: !selected)
            (self.tableView.cellForRow(at: indexPath!) as! AccessoryCell).toggleAccessory()
        }
        
    }
    
    func update(_ object: NSManagedObject, selected: Bool) {
        object.setValue(selected, forKey: "available")
        DatabaseManager.shared.saveContext()
    }
    
}
