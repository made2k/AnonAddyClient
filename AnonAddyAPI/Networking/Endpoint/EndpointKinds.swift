//
//  EndpointKinds.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/7/21.
//

import Foundation

internal enum EndpointKinds {
  
  /// An endpiont that requires no authentication
  enum Public: EndpointKind {
    
    static func prepare(_ request: inout URLRequest, with _: Void) {
      // Do nothing for public endpoints
    }
    
  }
  
  /// An endpoint requiring a signed in account for authenticated requests
  enum Private: EndpointKind {
    
    static func prepare(_ request: inout URLRequest, with token: AccessToken) {
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
      request.addValue("Bearer \(token.rawValue)", forHTTPHeaderField: "Authorization")
    }
    
  }
  
}
