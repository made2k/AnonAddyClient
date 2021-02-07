//
//  Account.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 12/23/20.
//

import Foundation

public struct Account: Decodable, Identifiable {
  
  public let id: UUID
  public let username: String
  
}
