//
//  Email.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/12/21.
//

import Foundation

public struct Email: Codable, RawRepresentable {

  public var rawValue: String
  
  public var localPart: String
  public var domain: Domain
  
  public init?(rawValue: String) {
    self.rawValue = rawValue
    
    let parts = rawValue.components(separatedBy: "@")
    guard parts.count == 2 else {
      return nil
    }
    
    localPart = parts[0]
    domain = Domain(rawValue: parts[1])
  }
  
}
