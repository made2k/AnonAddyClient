//
//  AliasLoader.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/12/21.
//

import Combine
import Foundation

public struct AliasLoader {
  
  private let urlSession: URLSession
  private let userSession: Client
  
  public init(client: Client, session: URLSession = URLSession.shared) {
    self.userSession = client
    self.urlSession = session
  }

  public func activate(alias: Alias) -> AnyPublisher<Alias, APIError> {
    urlSession.publisher(for: .activate(id: alias.id.uuidString), using: userSession.token)
  }
  
  public func deactivate(alias: Alias) -> AnyPublisher<EmptyResponse, APIError> {
    urlSession.emptyPublisher(for: .deactivate(alias.id.uuidString), using: userSession.token)
  }

  public func loadAliases(id: String? = nil) -> AnyPublisher<[Alias], APIError> {
    urlSession.publisher(for: .aliases(id: id), using: userSession.token)
  }
    
  public func update(alias: Alias, description: String?) -> AnyPublisher<Alias, APIError> {
    urlSession.publisher(for: .update(id: alias.id.uuidString, description: description), using: userSession.token)
  }
  
}

extension Endpoint where Kind == EndpointKinds.Private, Response == [Alias] {
  
  static func aliases(id: String?) -> Self {
    let path: String = ["aliases", id].compactMap { $0 }.joined(separator: "/")
    return Endpoint(path: path)
  }
  
}

extension Endpoint where Kind == EndpointKinds.Private, Response == Alias {
  
  static func activate(id: String) -> Self {
    Endpoint(path: "active-aliases", queryItems: [URLQueryItem(name: "id", value: id)], method: .post)
  }
  
  static func update(id: String, description: String?) -> Self {
    Endpoint(path: "aliases/\(id)", queryItems: [URLQueryItem(name: "description", value: description)], method: .patch)
  }
  
}

extension Endpoint where Kind == EndpointKinds.Private, Response == EmptyResponse {
  
  static func deactivate(_ id: String) -> Self {
    Endpoint(path: "active-aliases/\(id)", method: .delete)
  }
  
}

