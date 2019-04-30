//
//  CustomTableView.swift
//  My IT Course
//
//  Created by Harry Roberts on 21/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class GenericDataSource<T>: NSObject, UITableViewDataSource {
    
    typealias CellConfigurator = (T, UITableViewCell) -> Void
    
    var items: [T]
    let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(items: [T], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.items = items
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cellConfigurator(item, cell)
        
        return cell
    }
    
}
