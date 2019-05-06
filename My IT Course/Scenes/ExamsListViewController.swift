//
//  ExamsListViewController.swift
//  My IT Course
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import UIKit
import CoreData

class ExamsListViewController: GenericTableViewController {
    
    var exams: [[Exam]] = []
    let datePicker = UIDatePicker()
    var dateTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshTable()
    }
    
    func refreshTable() {
        
        self.exams.removeAll()
        if let savedExams = DatabaseManager.shared.fetchExams() {
            self.exams.append(savedExams.filter( { $0.future == false } ))
            self.exams.append(savedExams.filter( { $0.future == true } ))
        }
        
        self.setupDataSource()
        self.setupTable()
        self.sectionTitles = ["Results of exams taken", "Future scheduled exams"]
        
        self.tableView.reloadData()
        
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let navItem = UIBarButtonItem(image: UIImage(named: "ic_plus", in: Bundle(for: type(of: self)), compatibleWith: nil), style: .plain, target: self, action: #selector(add))
        
        self.navigationItem.rightBarButtonItem = navItem
    }
    
    @objc func add() {
        print("add tapped")
        
        let alert = UIAlertController(title: "Add Exam", message: "Select the tyoe of exam data you want to add", preferredStyle: .actionSheet)

        var allowResults = true
        var allowFutureExams = true
        
        // Limit adding items to 3
        if let savedExams = DatabaseManager.shared.fetchExams() {
            if savedExams.filter ( { $0.future == false } ).count < 3 {
                allowResults = true
            } else {
                allowResults = false
            }
            
            if savedExams.filter ( { $0.future == true } ).count < 3 {
                allowFutureExams = true
            } else {
                allowFutureExams = false
            }
            
        }
        
        if allowResults {
            let examResultAction = UIAlertAction(title: "Exam result", style: .default) { (action) in
                self.createAlertForExam(true)
            }
            alert.addAction(examResultAction)
        }
        
        if allowFutureExams {
            let futureExamDateAction = UIAlertAction(title: "Future exam date", style: .default) { (action) in
                self.createAlertForExam(false)
            }
            alert.addAction(futureExamDateAction)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertForExam(_ result: Bool = true) {
        
        let examEntity = NSEntityDescription.entity(forEntityName: "Exam", in: DatabaseManager.shared.persistentContainer.viewContext)!
        var future = false
        
        let alertController = UIAlertController(title: "Exam result", message: "", preferredStyle: .alert)
        
        alertController.addTextField { nameTextField in
            nameTextField.placeholder = "Exam name"
        }
        
        if result {
            
            alertController.addTextField { resultTextField in
                resultTextField.placeholder = "Exam result"
                resultTextField.keyboardType = .decimalPad
            }
            
        } else {
            
            future = true
            
            alertController.addTextField { textField in
                textField.placeholder = "Exam date"
                textField.inputAccessoryView = self.showDatePicker()
                textField.inputView = self.datePicker
                self.dateTextField = textField

            }
            
        }
        
        let confirmAction = UIAlertAction(title: "Add", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let examName = alertController.textFields?.first?.text, let examDetail = alertController.textFields?.last?.text else { return }
            let exam = NSManagedObject(entity: examEntity, insertInto: DatabaseManager.shared.persistentContainer.viewContext)
            exam.setValue(examName, forKey: "name")
            exam.setValue(future ? examDetail : examDetail + "%", forKey: "detail")
            exam.setValue(future, forKey: "future")
            
            DatabaseManager.shared.saveContext()
            self.refreshTable()
        }
        alertController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showDatePicker() -> UIView {
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action:#selector(doneToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelToolbar))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        return toolbar
        
    }
    
    @objc func doneToolbar() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.dateTextField?.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelToolbar() {
        self.view.endEditing(true)
    }
    
    private func setupDataSource() {
        
        self.dataSource = GenericDataSource(items: exams,
                                            reuseIdentifier: GenericTableViewController.detailsCell) { (exam, @objc  cell) in
                                                cell.textLabel?.text = exam.name
                                                cell.detailTextLabel?.text = exam.detail
        }
        
    }

}
