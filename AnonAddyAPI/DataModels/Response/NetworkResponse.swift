//
//  NetworkResponse.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/7/21.
//

import Foundation

struct NetworkResponse<Wrapped: Decodable>: Decodable {
  
  var data: Wrapped
  
}
