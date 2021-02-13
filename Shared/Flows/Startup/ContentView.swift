//
//  ContentView.swift
//  Shared
//
//  Created by Zach McGaughey on 12/23/20.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var model: AppModel
  
  var body: some View {
    
    switch model.authenticatedModel {
    
    case .some(let model):
      AuthenticatedView()
        .environmentObject(model)
      
    case .none:
      LoginView(viewModel: LoginViewModel(accountModel: model.accountModel))
          
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(model: AppModel.shared)
  }
}
