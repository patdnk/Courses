//
//  ModuleItem.swift
//  My IT Course
//
//  Created by Harry Roberts on 08/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation

public enum ModuleStatus: String, Codable {
    case ongoing = "On going"
    case completed = "Completed"
    case notstarted = "Not started"
}

extension ModuleStatus {
    enum CodingError: Error { case decoding(String) }
    enum CodableKeys: String, CodingKey { case ongoing, completed, notstarted }
}

public struct ModuleItem: Codable {
    public var name: String
    public var units: [UnitItem]
    public var description: String
    public var status: ModuleStatus
}

extension ModuleItem: Equatable {
    public static func == (lhs: ModuleItem, rhs: ModuleItem) -> Bool {
        return lhs.name == rhs.name && lhs.description == rhs.description && lhs.units == rhs.units
    }
}
