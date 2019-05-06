//
//  Programme+CoreDataClass.swift
//  CDTest
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation
import CoreData

@objc(Programme)
public class Programme: NSManagedObject, Codable {
    
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var available: Bool
    @NSManaged public var modules: Set<Module>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case available
        case modules
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name ?? "", forKey: .name)
        try container.encode(status ?? "", forKey: .status)
        try container.encode(available, forKey: .available)
        try container.encode(modules, forKey: .modules)
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Programme", in: managedObjectContext) else {  fatalError("Failed to decode Programme!")  }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)    
        id = try values.decode(Int16.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        status = try values.decode(String.self, forKey: .status)
        available = try values.decode(Bool.self, forKey: .available)
        modules = try values.decode(Set<Module>.self, forKey: .modules)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Programme> {
        return NSFetchRequest<Programme>(entityName: "Programme")
    }
    
}

// MARK: Generated accessors for modules
extension Programme {
    
    @objc(addModulesObject:)
    @NSManaged public func addToModules(_ value: Module)
    
    @objc(removeModulesObject:)
    @NSManaged public func removeFromModules(_ value: Module)
    
    @objc(addModules:)
    @NSManaged public func addToModules(_ values: Set<Module>)
    
    @objc(removeModules:)
    @NSManaged public func removeFromModules(_ values: Set<Module>)
    
}
