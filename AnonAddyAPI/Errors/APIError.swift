//
//  APIError.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/8/21.
//

import Foundation

public enum APIError: Error {
  
  // HTTP Errors
  case badRequest
  case unauthenticated
  case forbidden
  case notFound
  case notAllowed
  case validationError
  case tooManyRequests
  case internalServerError
  case serviceUnavailable
  
  // Client Errors
  case invalidEndpoint
  
  // Other
  case unknown(Error)
  
  init(error: Error) {

    if let apiError = error as? APIError {
      self = apiError
      
    } else {
      self = .unknown(error)
    }
    
  }
  
  static func from(_ statusCode: Int) -> APIError {
    
    switch statusCode {
    case 400:
      return .badRequest
      
    case 401:
      return .unauthenticated
      
    case 403:
      return .forbidden
      
    case 404:
      return .notFound
      
    case 405:
      return .notAllowed
      
    case 422:
      return .validationError
      
    case 429:
      return .tooManyRequests
      
    case 500:
      return .internalServerError
      
    case 503:
      return .serviceUnavailable
      
    default:
      return .unknown(APIError.badRequest)
    }
    
  }
  
}
