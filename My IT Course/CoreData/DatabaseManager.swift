//
//  DatabaseManager.swift
//  CDTest
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Courses")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Data saved")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func importData(completion:@escaping () -> ()){
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else { fatalError("no file") }
        do{
            let json = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = self.persistentContainer.viewContext
            do {
                let subjects = try decoder.decode([Programme].self, from: json)
                
//                for subject in subjects where subject.parentid != 0{
//                    guard let parentid = subject.parentid else { fatalError("Can not get parentid") }
//                    guard let parent = (subjects.filter { $0.id ==  parentid }.first) else { fatalError("Can not get parent") }
//                    subject.parent = parent
//                }
                do {
                    try self.saveContext()
                    completion()
                } catch {
                    print("Error")
                    completion()
                }
            } catch {
                print("Error")
                completion()
            }
        } catch {
            print("Error")
            completion()
        }
    }
    
    func fetchProgrammes() -> [Programme]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Programme")
        
        do {
            let fetchedData = try self.persistentContainer.viewContext.fetch(fetchRequest) as! [Programme]
            if fetchedData.count > 0 {
                return fetchedData
            } else {
                return nil
            }
        } catch {
            fatalError("Failed to fetch Programmes: \(error)")
        }
        
        return nil
    }
    
    func fetchExams() -> [Exam]? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exam")
        
        do {
            let fetchedData = try self.persistentContainer.viewContext.fetch(fetchRequest) as! [Exam]
            if fetchedData.count > 0 {
                return fetchedData
            } else {
                return nil
            }
        } catch {
            fatalError("Failed to fetch Exams: \(error)")
        }
        
        return nil
    }
    
    func checkInitialData() {
        
        if self.fetchProgrammes() == nil {
            DatabaseManager.shared.importData {
                print("DatabaseManager.shared.importData finished")
            }
        } else {
            print("Data already stored and ready to be read")
        }
        
    }
    
}
