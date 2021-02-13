//
//  Client+Preview.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/12/21.
//

import AnonAddyAPI
import Foundation

extension Client {
  
  /// Create a dummy client that won't send requests
  static var preview: Client {
    return Client(token: AccessToken(rawValue: ""))
  }
  
}
