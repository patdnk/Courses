//
//  Module+CoreDataProperties.swift
//  CDTest
//
//  Created by Harry Roberts on 30/04/2019
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation
import CoreData


@objc(Module)
public class Module: NSManagedObject, Codable {
    
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var status: String?
    @NSManaged public var units: Set<Unit>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case status
        case available
        case units
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name ?? "", forKey: .name)
        try container.encode(desc ?? "", forKey: .desc)
        try container.encode(status ?? "", forKey: .status)
        try container.encode(units, forKey: .units)
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Module", in: managedObjectContext) else {  fatalError("Failed to decode Module!")  }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int16.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        desc = try values.decode(String.self, forKey: .desc)
        status = try values.decode(String.self, forKey: .status)
        units = try values.decode(Set<Unit>.self, forKey: .units)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Module> {
        return NSFetchRequest<Module>(entityName: "Module")
    }
    
}

// MARK: Generated accessors for units
extension Module {

    @objc(addUnitsObject:)
    @NSManaged public func addToUnits(_ value: Unit)

    @objc(removeUnitsObject:)
    @NSManaged public func removeFromUnits(_ value: Unit)

    @objc(addUnits:)
    @NSManaged public func addToUnits(_ values: Set<Unit>)

    @objc(removeUnits:)
    @NSManaged public func removeFromUnits(_ values: Set<Unit>)

}
