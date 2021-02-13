//
//  Array+QueryItem.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/18/21.
//

import Foundation

extension Array where Element == URLQueryItem {
  
  func percentEncoded() -> Data? {
    
    compactMap { queryItem -> String? in
      let optionalKey: String? = queryItem.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      let optionalValue: String? = queryItem.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      
      guard let key = optionalKey, let value = optionalValue else {
        return nil
      }
      
      return "\(key)=\(value)"
    }
    .joined(separator: "&")
    .data(using: .utf8)
    
  }
  
}
