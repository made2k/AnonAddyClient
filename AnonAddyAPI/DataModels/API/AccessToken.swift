//
//  AccessToken.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 12/23/20.
//

import Foundation

public struct AccessToken: Codable, RawRepresentable {
  
  public var rawValue: String
  
  public init(rawValue: String) {
    self.rawValue = rawValue
  }
  
}
