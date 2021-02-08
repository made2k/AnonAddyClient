//
//  AccountLoader.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/7/21.
//

import Combine
import Foundation

public struct AccountLoader {
  
  private let urlSession: URLSession
  private let userSession: Client
  
  public init(client: Client, session: URLSession = URLSession.shared) {
    self.userSession = client
    self.urlSession = session
  }
  
  public func loadAccount() -> AnyPublisher<Account, APIError> {
    urlSession.publisher(for: .account(), using: userSession.token)
  }
  
}

extension Endpoint where Kind == EndpointKinds.Private, Response == Account {
  
  static func account() -> Self {
    Endpoint(path: "account-details")
  }
  
}
