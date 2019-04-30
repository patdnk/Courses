//
//  DataManager.swift
//  My IT Course
//
//  Created by Harry Roberts on 08/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation

public enum CodingError: Error {
    case unknownValue
}

public class DataManager {
    
    public let kProgrammes = "Programmes"
    
    private var defaults: UserDefaults!
    public static let shared = DataManager()
    public var programmes: [ProgrammeItem] {
        get {
            var programmesArray = [ProgrammeItem]()
            if let programmesData = self.read(key: kProgrammes) as? [Data] {
                for programmeData in programmesData {
                    if let programmeDecoded = try! PropertyListDecoder().decode(Array<ProgrammeItem>?.self, from: programmeData) {
                        programmesArray.append(contentsOf: programmeDecoded)
                    }
                }
                return programmesArray
                
            } else {
                
                if let url = Bundle.main.url(forResource: "dataset", withExtension: "json") {
                    do {
                        let data = try Data(contentsOf: url)
                        let jsonData = try JSONDecoder().decode([ProgrammeItem].self, from: data)
                        print ("jsonData: \n \(jsonData)")
                        programmesArray = jsonData
                        let programmeItems = [try! PropertyListEncoder().encode(programmesArray)]
                        self.write(key: kProgrammes, value: programmeItems)
                        print("## Data read from JSON and stored in UserDefaults ##")
                        return programmesArray
                    } catch {
                        print("error:\(error)")
                    }
                    
                }
            }
            return []
        }
    }
    
    fileprivate init() {
        self.defaults = UserDefaults.standard
    }
    
    public func loadInitialDataSet() {
        
        
    }
    
    public func read(key: String) -> Any? {
        return self.defaults.value(forKey: key)
        
    }
    
    public func write(key: String, value: Any) {
        self.defaults.set(value, forKey: key)
        self.synchronize()
    }
    
    public func saveData(_ programmes: [ProgrammeItem]) {
        let programmeItems = [try! PropertyListEncoder().encode(programmes)]
        self.write(key: kProgrammes, value: programmeItems)
        print("## Data saved ##")
    }
    
    public func synchronize() {
        self.defaults.synchronize()
    }

}
