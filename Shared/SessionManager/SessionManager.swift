//
//  SessionManager.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/8/21.
//

import AnonAddyAPI
import Combine
import Foundation
import KeychainAccess

final class SessionManager {
  
  static let shared = SessionManager()
  
  private static let tokenKey: String = "accesstoken"
  
  // Combine observers for client
  private let subject = PassthroughSubject<Client?, Never>()
  var publisher: AnyPublisher<Client?, Never> {
    subject.eraseToAnyPublisher()
  }
  
  var client: Client? {
    didSet {
      keychain[string: Self.tokenKey] = client?.token.rawValue
      subject.send(client)
    }
  }
  
  private let keychain: Keychain
  
  private init() {
    guard let bundleId: String = Bundle.main.bundleIdentifier else {
      preconditionFailure("No bundle ID unable to load keychain")
    }
    
    let service: String = "\(bundleId).keychain"
    self.keychain = Keychain(service: service)
    
    if let savedToken: String = keychain[string: Self.tokenKey] {
      let accessToken: AccessToken = AccessToken(rawValue: savedToken)
      self.client = Client(token: accessToken)
    }
    
  }
  
}
