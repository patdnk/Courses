//
//  ReusableTableViewController.swift
//  My IT Course
//
//  Created by Pat Dynek on 21/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ReusableTableViewController: UIViewController, UITableViewDelegate {
    
    static let accessoryCell = "AccessoryCell"
    static let basicCell = "BasicCell"
    static let detailCell = "DetailCell"
    static let subtitleCell = "SubtitleCell"
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: Any!
    var sectionTitles: [String]?
//    fileprivate var selectedItem: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setupTable() {
        self.tableView.register(AccessoryCell.self, forCellReuseIdentifier: "AccessoryCell")
        self.tableView.dataSource = self.dataSource as? UITableViewDataSource
        self.tableView.delegate = self
        self.tableView.sectionFooterHeight = 0
        self.tableView.sectionHeaderHeight = 0
        self.tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    @objc func accessoryTapped(_ sender: UIButton) {
        let tapPoint = self.tableView.convert(sender.bounds.origin, from: sender)
        let indexPath = self.tableView.indexPathForRow(at: tapPoint)
        //update your model to reflect task at indexPath is finished and reloadData
        print(indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.sectionTitles != nil {
            let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 32)))
            headerView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 16, y: 0), size: CGSize(width: headerView.frame.width - 16, height: headerView.frame.height)))
            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            titleLabel.text = self.sectionTitles![section]
            headerView.addSubview(titleLabel)
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        print((self.dataSource as! ReusableTableViewDataSource<self.itemType>).items[indexPath.row].name)
//        if let programmesSource = self.dataSource as? ReusableTableViewDataSource<ProgrammeItem> {
//            print(programmesSource.items[indexPath.row].name)
//            let subLevelViewController = self.createSublevelTable(items: programmesSource.items[indexPath.row].modules, title: "Modules", sectionTitles: ["Modules in \(programmesSource.items[indexPath.row].name)"], reuseIdentifier: "BasicCell")
//            self.navigationController?.present(subLevelViewController, animated: true, completion: nil)
//        } else if let modulesSource = self.dataSource as? ReusableTableViewDataSource<ModuleItem>  {
//            print(modulesSource.items[indexPath.row].name)
//        }
//
//    }
    
//    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        print(#function)
//    }
//
//    //Custom Accessory delegate
//
//    func didTapActionButton(selected: Bool, sender: UIButton) {
//        print(#function)
//    }
    
    // Create another table
    
//    func createSublevelTable(items: [Any], title: String, sectionTitles: [String], reuseIdentifier: String) -> UIViewController {
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let sublevelTableController = mainStoryboard.instantiateViewController(withIdentifier: "ReusableTableViewController") as! ReusableTableViewController
//
//        let sublevelDataSource = ReusableTableViewDataSource(items: items,
//                                                               reuseIdentifier: reuseIdentifier) { (item, @objc  cell) in
//                                                                if item is ModuleItem {
//                                                                    cell.textLabel?.text = (item as! ModuleItem).name
//                                                                } else if item is UnitItem  {
//                                                                    cell.textLabel?.text = (item as! UnitItem).name
//                                                                }
//        }
//
//        sublevelTableController.dataSource = sublevelDataSource
//        sublevelTableController.sectionTitles = sectionTitles
//        sublevelTableController.title = title
//
//        return sublevelTableController
//    }
    
}
