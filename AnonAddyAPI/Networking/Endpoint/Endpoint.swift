//
//  Endpoint.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/7/21.
//

import Foundation

internal struct Endpoint<Kind: EndpointKind, Response: Decodable> {
  
  var path: String
  var queryItems = [URLQueryItem]()
  
}

internal extension Endpoint {
  
  func makeRequest(with data: Kind.RequestData) -> URLRequest? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "app.anonaddy.com"
    components.path = "/api/v1/" + path
    components.queryItems = queryItems.isEmpty ? nil : queryItems
    
    // If either the path or the query items passed contained
    // invalid characters, we'll get a nil URL back:
    guard let url = components.url else {
      return nil
    }
    
    var request = URLRequest(url: url)
    Kind.prepare(&request, with: data)
    return request
  }
  
}
