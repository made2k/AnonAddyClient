//
//  Alias.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/12/21.
//

import Foundation

public struct Alias: Decodable {
  
  public let id: UUID
  public let userId: UUID
  public let domain: Domain
  public let email: Email
  public let description: String?
  
  public let active: Bool

  public let emailsForwarded: Int
  public let emailsBlocked: Int
  public let emailsReplied: Int
  public let emailsSent: Int
  
  public let createdAt: Date
  public let updatedAt: Date
  
  public static func random() -> Alias {
    
    let domainString: String = "\(UUID().uuidString.prefix(8)).com"
    let localString: String = String(UUID().uuidString.prefix(8))
    let creationDate: Date = Date().addingTimeInterval(-1 * Double.random(in: 60..<365*24*60*60))
    
    return Alias(
      id: UUID(),
      userId: UUID(),
      domain: Domain(rawValue: domainString),
      email: Email(rawValue: "\(localString)@\(domainString)").unsafelyUnwrapped,
      description: nil,
      active: Bool.random(),
      emailsForwarded: Int.random(in: 0..<20),
      emailsBlocked: Int.random(in: 0..<20),
      emailsReplied: Int.random(in: 0..<20),
      emailsSent: Int.random(in: 0..<20),
      createdAt: creationDate,
      updatedAt: creationDate
    )
  }
}
