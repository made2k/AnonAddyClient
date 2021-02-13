//
//  Assets.swift
//  AnonAddyClient (iOS)
//
//  Created by Zach McGaughey on 2/7/21.
//

import Foundation
import SwiftUI

extension Image {
  
  enum Custom {
    static let logoFull: SwiftUI.Image = SwiftUI.Image("logoFull")
  }
  
}

extension Color {
  static let brandBackground: Color = Color("BrandBackground")
  static let brandButtonBackground: Color = Color("BrandButtonBackground")
  static let brandButtonText: Color = Color("BrandButtonText")
}

enum Strings {
  
  private static func string(with key: String, table: String, arguments: [CVarArg] = []) -> String {
    let format: String = NSLocalizedString(key, tableName: table, bundle: Bundle.main, comment: "")
    return String(format: format, arguments: arguments)
  }
  
  enum AliasList {
    static let navigationHeader = string(with: "navigation header")
    
    private static func string(with key: String, comment: String = "") -> String {
      Strings.string(with: key, table: "AliasList")
    }
  }
  
  enum AliasListItem {
    static func createdInline(_ value: String) -> String {
      string(with: "created inline", value)
    }
    static let forwardsInline = string(with: "forwards inline")
    static let blockedInline = string(with: "blocked inline")
    static let sentInline = string(with: "sent inline")
    static let copyButton = string(with: "copy button")
    static let sendEmailButton = string(with: "send email button")
    static let created = string(with: "created")
    static func createTime(_ value: String) -> String {
      string(with: "create time", value)
    }
    static let forwarded = string(with: "forwarded")
    static let blocked = string(with: "blocked")
    static let replySent = string(with: "reply sent")
    static let active = string(with: "active")
    static let descriptionPlaceholder = string(with: "description placeholder")
    
    private static func string(with key: String, comment: String = "", _ arguments: CVarArg...) -> String {
      Strings.string(with: key, table: "AliasListItem", arguments: arguments)
    }
  }
  
  enum Authenticated {
    static let aliases = string(with: "aliases menu item")
    static let logOut = string(with: "log out")
    
    private static func string(with key: String, comment: String = "", _ arguments: CVarArg...) -> String {
      Strings.string(with: key, table: "Authenticated", arguments: arguments)
    }

  }
  
  enum Login {
    static let accessTokenPlaceholder = string(with: "access token placeholder")
    static let accessTokenInstructions = string(with: "access token instructions")
    static let loginButtonTitle = string(with: "login button title")
    static let loginErrorTitle = string(with: "login error title")
    static let loginErrorButton = string(with: "login error button")
    
    private static func string(with key: String, comment: String = "") -> String {
      Strings.string(with: key, table: "Login")
    }
  }
  
}
