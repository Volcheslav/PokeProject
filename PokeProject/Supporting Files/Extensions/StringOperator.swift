//
//  StringOperator.swift
//  PokeProject
//
//  Created by User on 10.11.22.
//

import Foundation

// swiftlint:disable all
postfix operator §
postfix func § (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}
