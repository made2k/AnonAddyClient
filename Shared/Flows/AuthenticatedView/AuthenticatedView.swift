//
//  AuthenticatedView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/12/21.
//

import AnonAddyAPI
import SwiftUI

struct AuthenticatedView: View {
  
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @EnvironmentObject var model: AuthenticatedModel
  
  var body: some View {
    
    switch horizontalSizeClass {
    case .compact:
      CompactAuthenticatedView(model: model)
      
    default:
      RegularAuthenticatedView(model: model, selectedView: .aliases)
    }
    
  }
  
}

struct AuthenticatedView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      
      AuthenticatedView()
        .previewDevice("iPhone 11")
        .environment(\.horizontalSizeClass, .compact)
        .environmentObject(AuthenticatedModel(client: .preview, accountModel: AccountModel.shared))
      
      AuthenticatedView()
        .previewDevice("iPad Pro (11-inch) (2nd generation)")
        .environment(\.horizontalSizeClass, .regular)
        .environmentObject(AuthenticatedModel(client: .preview, accountModel: AccountModel.shared))
      
    }
  }
}
