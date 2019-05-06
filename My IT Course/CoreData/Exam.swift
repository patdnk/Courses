//
//  Exam.swift
//  My IT Course
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation
import CoreData

@objc(Exam)
public class Exam: NSManagedObject, Codable {
    
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var detail: String?
    @NSManaged public var future: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detail
        case future
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name ?? "", forKey: .name)
        try container.encode(detail ?? "", forKey: .detail)
        try container.encode(future, forKey: .future)
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Exam", in: managedObjectContext) else {  fatalError("Failed to decode Exam!")  }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int16.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        detail = try values.decode(String.self, forKey: .detail)
        future = try values.decode(Bool.self, forKey: .future)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exam> {
        return NSFetchRequest<Exam>(entityName: "Exam")
    }
    
}
