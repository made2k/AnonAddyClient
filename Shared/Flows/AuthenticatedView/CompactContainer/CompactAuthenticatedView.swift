//
//  CompactAuthenticatedView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/12/21.
//

import AnonAddyAPI
import SwiftUI

struct CompactAuthenticatedView: View {
  
  @ObservedObject var model: AuthenticatedModel
  
  var body: some View {
    TabView {
      
      NavigationView {
        AliasListView(viewModel: model.aliasesModel)
          .toolbar {
            Button(Strings.Authenticated.logOut) {
              try? model.accountModel.logout()
            }
          }
      }
      .tabItem {
        VStack {
          Image(systemName: "person")
          Text(Strings.Authenticated.aliases)
        }
      }
    }
    
  }
}

struct CompactAuthenticatedView_Previews: PreviewProvider {
  static var previews: some View {
    CompactAuthenticatedView(model: AuthenticatedModel(client: .preview, accountModel: AccountModel.shared))
      .previewDevice("iPhone 11")
  }
}
