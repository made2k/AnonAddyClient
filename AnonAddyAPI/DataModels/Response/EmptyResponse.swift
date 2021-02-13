//
//  EmptyResponse.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/18/21.
//

import Foundation

public struct EmptyResponse: Decodable {
  
  public init(from decoder: Decoder) throws { /* Empty */ }
  init() {  }
  
}
