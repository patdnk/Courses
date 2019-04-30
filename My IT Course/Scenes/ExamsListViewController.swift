//
//  ExamsListViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit

class ExamsListViewController: GenericTableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupDataSource()
        self.setupTable()
        self.sectionTitles = ["Results of exams taken", "Future scheduled exams"]
        
    }
    
    private func setupDataSource() {
        
        let exam1 = ExamItem(name: "Exam 1", detail: "99%")
        let exam2 = ExamItem(name: "Exam 2", detail: "89%")
        let exam3 = ExamItem(name: "Exam 3", detail: "79%")
        
        let fexam1 = ExamItem(name: "Exam 4", detail: "13/05/2019")
        let fexam2 = ExamItem(name: "Exam 5", detail: "15/05/2019")
        let fexam3 = ExamItem(name: "Exam 6", detail: "17/05/2019")
        
        let exams = [exam1, exam2, exam3, fexam1, fexam2, fexam3]
        
        self.dataSource = GenericDataSource(items: exams, reuseIdentifier:  GenericTableViewController.detailsCell, cellConfigurator: { (exam, @objc cell) in
            cell.textLabel?.text = exam.name
            cell.detailTextLabel?.text = exam.detail
        })
    }

}
