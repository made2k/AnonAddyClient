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
  
  enum Login {
    static let accessTokenPlaceholder = string(with: "access token placeholder")
    static let accessTokenInstructions = string(with: "access token instructions")
    static let loginButtonTitle = string(with: "login button title")
    
    private static func string(with key: String, comment: String = "") -> String {
      NSLocalizedString(key, tableName: "Login", bundle: Bundle.main, comment: "")
    }
  }
  
}
