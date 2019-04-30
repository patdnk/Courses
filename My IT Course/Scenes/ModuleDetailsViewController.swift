//
//  ModuleDetailsViewController.swift
//  My IT Course
//
//  Created by Pat Dynek on 29/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ModuleDetailsViewController: UIViewController {
    
    var module: ModuleItem!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "\(module.name) description"
        self.descriptionTextView.text = module.description
    }

}
