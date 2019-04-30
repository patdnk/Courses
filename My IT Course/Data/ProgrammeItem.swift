//
//  ProgrammeItem.swift
//  My IT Course
//
//  Created by Harry Roberts on 08/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation

public enum ProgrammeStatus: String, Codable {
    case none = "None"
    case certified = "Certified"
    case inProgress = "In progress"
}

extension ProgrammeStatus {
    enum CodingError: Error { case decoding(String) }
    enum CodableKeys: String, CodingKey { case certified, inProgress }
}

public struct ProgrammeItem: Codable {
    public var name: String
    public var modules: [ModuleItem]
    public var status: ProgrammeStatus
    public var available: Bool = false
}

extension ProgrammeItem: Equatable {
    public static func == (lhs: ProgrammeItem, rhs: ProgrammeItem) -> Bool {
        return lhs.name == rhs.name && lhs.modules == rhs.modules
    }
}
