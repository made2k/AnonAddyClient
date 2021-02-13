//
//  JSONDecoder+DefaultTypes.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/12/21.
//

import Foundation

extension JSONDecoder {
  
  static func `default`() -> JSONDecoder {
    let decoder = JSONDecoder()
    
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom { decoder -> Date in
      let container = try decoder.singleValueContainer()
      let dateString: String = try container.decode(String.self)
      
      let formatter = DateFormatter()
      formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
      
      guard let date = formatter.date(from: dateString) else {
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string: \(dateString)")
      }
      
      return date
    }
    
    return decoder

  }
  
}
