//
//  Unit+CoreDataClass.swift
//  CDTest
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation
import CoreData

@objc(Unit)
public class Unit: NSManagedObject, Codable {
    
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name ?? "", forKey: .name)
        try container.encode(status ?? "", forKey: .status)
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Unit", in: managedObjectContext) else {  fatalError("Failed to decode Unit!")  }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int16.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        status = try values.decode(String.self, forKey: .status)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Unit> {
        return NSFetchRequest<Unit>(entityName: "Unit")
    }

}
