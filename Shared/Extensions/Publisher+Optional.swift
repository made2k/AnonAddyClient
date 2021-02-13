//
//  Publisher+Optional.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/14/21.
//

import Combine
import Foundation

protocol OptionalConvertable {
  associatedtype Element
  var asOptional: Optional<Element> { get }
}

extension Optional: OptionalConvertable {
  var asOptional: Optional<Wrapped> { self }
}

extension Publisher {
  
  /// Returns a publisher with an optional Output value.
  func asOptional() -> Publishers.Map<Self, Output?> {
    
    return map { (value: Output) -> Output? in
      value
    }
    
  }
  
}

extension Publisher where Output: OptionalConvertable {
  
  /**
   Replace an optional publisher output with a provided default value. This ensures the
   value will never be nil. If the original value is not nil, that is returned and th edefault
   value is ignored.
   */
  func replaceNil(with defaultValue: Output.Element) -> Publishers.Map<Self, Output.Element> {

    map { (value: Output) -> Output.Element in
      
      switch value.asOptional {
      case .some(let value):
        return value
        
      case .none:
        return defaultValue
      }
      
    }
    
  }
  
}
