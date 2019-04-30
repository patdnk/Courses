//
//  UnitItem.swift
//  My IT Course
//
//  Created by Harry Roberts on 08/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation

public enum UnitStatus: String, Codable {
    case completed = "Completed"
    case currentlyStudying = "Currently studying"
    case notStarted = "Not started"
}

extension UnitStatus {
    enum CodingError: Error { case decoding(String) }
    enum CodableKeys: String, CodingKey { case completed, currentlyStudying, notStarted }
}

public struct UnitItem: Codable {
    var name: String
    var status: UnitStatus
}

extension UnitItem: Equatable {
    public static func == (lhs: UnitItem, rhs: UnitItem) -> Bool {
        return lhs.name == rhs.name
    }
}
