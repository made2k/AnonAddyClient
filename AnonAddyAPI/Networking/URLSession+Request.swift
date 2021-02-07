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
  ) -> AnyPublisher<R, Error> {
    
    guard let request = endpoint.makeRequest(with: requestData) else {
      // TODO: Invalid endpoint error
      return Fail(error: ClientError.badRequest).eraseToAnyPublisher()
    }

    return dataTaskPublisher(for: request)
      .map(\.data)
      .decode(type: NetworkResponse<R>.self, decoder: decoder)
      .map(\.data)
      .eraseToAnyPublisher()

  }

}
