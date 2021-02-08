//
//  DataTaskPublisher+Validation.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/8/21.
//

import Combine
import Foundation

extension URLSession.DataTaskPublisher {
  
  /// Validate the http respone's status code
  func validate(_ acceptableCodes: Range<Int>) -> Publishers.TryMap<Self, Output> {
    
    tryMap { output in
      
      guard let response = output.response as? HTTPURLResponse else {
        throw APIError.badRequest
      }
      
      guard acceptableCodes.contains(response.statusCode) else {
        throw APIError.from(response.statusCode)
      }
      
      return output
    }
  }
  
}
