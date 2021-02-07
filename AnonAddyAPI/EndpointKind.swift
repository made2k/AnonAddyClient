//
//  EndpointKind.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/7/21.
//

import Foundation

internal protocol EndpointKind {
  associatedtype RequestData
  
  static func prepare(_ request: inout URLRequest, with data: RequestData)
}
