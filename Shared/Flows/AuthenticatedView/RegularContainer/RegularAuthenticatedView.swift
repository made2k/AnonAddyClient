//
//  RegularAuthenticatedView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/12/21.
//

import SwiftUI

struct RegularAuthenticatedView: View {
  
  enum SelectableView: String {
    case aliases
    case empty
  }
  
  @ObservedObject var model: AuthenticatedModel
  @State var selectedView: SelectableView?
  
  var body: some View {
    
    NavigationView {
      
      List {
        
        NavigationLink(
          destination: AliasListView(viewModel: model.aliasesModel),
          tag: SelectableView.aliases,
          selection: $selectedView
        ) {
          Image(systemName: "person")
          Text(Strings.Authenticated.aliases)
        }
        
        NavigationLink(
          destination: Text("Empty view"),
          tag: SelectableView.empty,
          selection: $selectedView
        ) {
          Image(systemName: "questionmark")
          Text("Empty Demo")
        }
        
      }
      .listStyle(SidebarListStyle())
      .toolbar {
        ToolbarItem(placement: .bottomBar) {
          Button(Strings.Authenticated.logOut) {
            try? model.accountModel.logout()
          }
        }
      }
      
      AliasListView(viewModel: model.aliasesModel)
      
    }
    .navigationViewStyle(DoubleColumnNavigationViewStyle())
    
    
  }
  
}

struct RegularAuthenticatedView_Previews: PreviewProvider {
  static var previews: some View {
    RegularAuthenticatedView(model: AuthenticatedModel(client: .preview, accountModel: AccountModel.shared))
      .previewDevice("iPad Pro (11-inch) (2nd generation)")
  }
}
