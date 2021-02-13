//
//  Client.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 12/23/20.
//

import Foundation

public struct Client {
  
  public let token: AccessToken
  
  public init(token: AccessToken) {
    self.token = token
  }
  
  // MARK: - Loaders
  
  public func accountLoader() -> AccountLoader {
    return AccountLoader(client: self)
  }
  
  public func aliasLoader() -> AliasLoader {
    return AliasLoader(client: self)
  }
  
}
