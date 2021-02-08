//
//  DisabledButtonStyle.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/7/21.
//

import Foundation
import SwiftUI

struct DisabledButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    DisabledButtonStyleView(configuration: configuration)
  }
  
}

private extension DisabledButtonStyle {
  
  struct DisabledButtonStyleView: View {
    
    @Environment(\.isEnabled) var isEnabled
    
    let configuration: DisabledButtonStyle.Configuration
    
    var body: some View {
      
      configuration.label
        .opacity(isEnabled ? 1 : 0.5)
      
    }
    
    
  }
  
}
