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
    decoder: JSONDecoder = .init()
  ) -> AnyPublisher<R, APIError> {
    
    guard let request = endpoint.makeRequest(with: requestData) else {
      return Fail(error: APIError.invalidEndpoint).eraseToAnyPublisher()
    }

    return dataTaskPublisher(for: request)
      .validate(200..<300)
      .map(\.data)
      .decode(type: NetworkResponse<R>.self, decoder: decoder)
      .map(\.data)
      .mapError(APIError.init)
      .eraseToAnyPublisher()

  }

}
