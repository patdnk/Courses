//
//  ConfigurableTableViewController.swift
//  My IT Course
//
//  Created by Dynek, Pat (SanTech) on 11/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

enum TableMode {
    case accessory, detail, subtitle
}

struct TableConfiguration {
    var sectionsTitles: [String]?
    var mode: TableMode
    var level: Int
    var accessoryAction: (() -> ())?
}

class ConfigurableTableViewController<T, Cell: UITableViewCell>: UITableViewController {
    private var items: [T]
    private var configure: (Cell, T) -> Void
    private var selectHandler: (T) -> Void
    private var configuration: TableConfiguration
    
    init(items: [T], configure: @escaping (Cell, T) -> Void, selectHandler: @escaping (T) -> Void,  configuration: TableConfiguration) {
        self.items = items
        self.configure = configure
        self.selectHandler = selectHandler
        self.configuration = configuration
        super.init(style: .plain)
        self.tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.configuration.sectionsTitles != nil {
            let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 32)))
            headerView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            let titleLabel = UILabel(frame: CGRect(origin: CGPoint.init(x: 16, y: 0), size: CGSize(width: headerView.frame.width - 16, height: headerView.frame.height)))
            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            titleLabel.text = self.configuration.sectionsTitles![section]
            headerView.addSubview(titleLabel)
            return headerView
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        selectHandler(item)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//
    }
   
}
