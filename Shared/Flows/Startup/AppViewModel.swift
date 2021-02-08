//
//  AppViewModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/8/21.
//

import AnonAddyAPI
import Foundation

final class AppViewModel: ObservableObject {
  
  enum State {
    case anonymous
    case loggedIn
    
    fileprivate init(_ client: Client?) {
      switch client {
      case .none:
        self = .anonymous
        
      case .some:
        self = .loggedIn
      }
    }
  }
  
  @Published private(set) var state: State
  
  init() {
    self.state = State(SessionManager.shared.client)

    SessionManager.shared.publisher
      .map(State.init)
      .assign(to: &$state)
    
  }
  
}
