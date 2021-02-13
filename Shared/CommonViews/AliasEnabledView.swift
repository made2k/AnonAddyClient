//
//  AliasEnabledView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/19/21.
//

import AnonAddyAPI
import SwiftUI

/// View with a toggle that binds to an AliasModel
struct AliasEnabledView: View {
  
  @ObservedObject var alias: AliasModel
  
  var body: some View {
    
    Toggle("Enabled", isOn: $alias.active)
      .labelsHidden()
    
  }
  
}

struct AliasEnabledView_Previews: PreviewProvider {
  
  static var previews: some View {
    AliasEnabledView(alias: .init(.random(), loader: Client.preview.aliasLoader()))
      .padding()
      .previewLayout(.sizeThatFits)
    
  }
}
