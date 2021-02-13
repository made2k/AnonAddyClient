//
//  Domain.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/12/21.
//

import Foundation

public struct Domain: Codable, RawRepresentable, ExpressibleByStringLiteral {

  public var rawValue: String
  
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
  
  public init(stringLiteral value: StringLiteralType) {
    self = Domain(rawValue: value)
  }
  
}
