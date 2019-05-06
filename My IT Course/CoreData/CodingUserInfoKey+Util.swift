//
//  CodingProgrammeInfoKey+Util.swift
//  CDTest
//
//  Created by Harry Roberts on 30/04/2019.
//  Copyright © 2019 BP0153386. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
