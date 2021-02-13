//
//  AliasListView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/12/21.
//

import AnonAddyAPI
import SwiftUI

struct AliasListView: View {
  
  @ObservedObject var viewModel: AliasesModel
  @State private var hasAppeared: Bool = false
  
  var body: some View {
    
    List(viewModel.aliases) { aliasModel in
      let viewModel = AliasListItemViewModel(aliasModel)
      AliasListItemView(viewModel: viewModel)
    }
    .onAppear(perform: loadData)
    .navigationTitle(Strings.AliasList.navigationHeader)
    
  }
  
  // This is a workaround since onAppear is called multiple times
  private func loadData() {
    guard hasAppeared == false else { return }
    hasAppeared = true
    viewModel.loadAllAliases()
  }
  
}

struct AliasListView_Previews: PreviewProvider {
  static var previews: some View {
    
    NavigationView {
      AliasListView(viewModel: AliasesModel.preview)
    }
    
  }
}
