//
//  URLSession+Request.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/7/21.
//

import Combine
import Foundation

extension URLSession {

  func publisher<K, R>(
    for endpoint: Endpoint<K, R>,
    using requestData: K.RequestData,
    decoder: JSONDecoder = .default()
  ) -> AnyPublisher<R, APIError> {
    
    let request: URLRequest
    
    do {
      request = try createRequest(from: endpoint, with: requestData)
      
    } catch {
      return Fail(error: APIError(error: error)).eraseToAnyPublisher()
    }

    return dataTaskPublisher(for: request)
      .validate(200..<300)
      .map(\.data)
      .decode(type: NetworkResponse<R>.self, decoder: decoder)
      .map(\.data)
      .mapError(APIError.init)
      .eraseToAnyPublisher()

  }
  
  func emptyPublisher<K>(
    for endpoint: Endpoint<K, EmptyResponse>,
    using requestData: K.RequestData
  ) -> AnyPublisher<EmptyResponse, APIError> {

    let request: URLRequest
    
    do {
      request = try createRequest(from: endpoint, with: requestData)
      
    } catch {
      return Fail(error: APIError(error: error)).eraseToAnyPublisher()
    }

    return dataTaskPublisher(for: request)
      .validate(200..<300)
      .map { _ -> EmptyResponse in
        EmptyResponse()
      }
      .mapError(APIError.init)
      .eraseToAnyPublisher()

  }
  
  private func createRequest<K, R>(from endpoint: Endpoint<K, R>, with requestData: K.RequestData) throws -> URLRequest {
    
    guard let request = endpoint.makeRequest(with: requestData) else {
      throw APIError.invalidEndpoint
    }
    
    if
      let headers: [String: String] = request.allHTTPHeaderFields,
      let authHeader = headers["Authorization"] {
      
      guard authHeader.replacingOccurrences(of: "Bearer ", with: "").isEmpty == false else {
        throw APIError.unauthenticated
      }
      
    }
    
    return request

  }


}
