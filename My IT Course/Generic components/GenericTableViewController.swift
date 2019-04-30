//
//  GenericTableViewController.swift
//  My IT Course
//
//  Created by Pat Dynek on 29/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class GenericTableViewController: UIViewController, UITableViewDelegate {
    
    static let accessoryCell = "AccessoryCell"
    static let basicCell = "BasicCell"
    static let detailCell = "DetailCell"
    static let subtitleCell = "SubtitleCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: Any!
    var sectionTitles: [String]?
    
    public func setupTable() {
        self.tableView.register(AccessoryCell.self, forCellReuseIdentifier: "AccessoryCell")
        self.tableView.dataSource = self.dataSource as? UITableViewDataSource
        self.tableView.delegate = self
        self.tableView.sectionFooterHeight = 0
        self.tableView.sectionHeaderHeight = 0
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: Data source methods
    
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

}
