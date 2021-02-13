//
//  AnonAddyClientApp.swift
//  Shared
//
//  Created by Zach McGaughey on 12/23/20.
//

import SwiftUI

@main
struct AnonAddyClientApp: App {
  
  @StateObject private var model = AppModel.shared
    
  var body: some Scene {
    
    WindowGroup {
      
      ContentView(model: model)
        .onAppear(perform: initializeAccount)
      
    }
    
  }
  
  /// Load our account to setup initial values. This will also verify that our auth token
  //// is still valid, if not this should log us out and reset the state of the app.
  private func initializeAccount() {
    model.accountModel.loadAccount()
  }
}
