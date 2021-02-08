//
//  ContentView.swift
//  Shared
//
//  Created by Zach McGaughey on 12/23/20.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject var viewModel: AppViewModel = AppViewModel()
  
  var body: some View {
    
    switch viewModel.state {
    case .anonymous:
      LoginView()
      
    case .loggedIn:
      TempLoggedIn()
    }
    
  }
}

private struct TempLoggedIn: View {
  
  var body: some View {
    
    Button("Log out") {
      SessionManager.shared.client = nil
    }
    
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
