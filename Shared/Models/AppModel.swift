//
//  AppModel.swift
//  AnonAddyClient (iOS)
//
//  Created by Zach McGaughey on 2/14/21.
//

import Foundation

/**
 AppModel is a basic global level model. It is responsable for providing the
 optional authentication model that indicates the application is logged in.
 
 The AppModel contains an account model that is used for authentication purposes.
 When the the users signs in with an account, this class creates the authenticated model
 and published the value. This can then be used throughout the app and indicates
 that the user is signed in.
 */
final class AppModel: ObservableObject {
  
  static var shared = AppModel()
  
  @Published var accountModel = AccountModel.shared
  @Published var authenticatedModel: AuthenticatedModel?
  
  private init() {
    
    accountModel
      .$state
      .map { [accountModel] (state: AccountModel.State) -> AuthenticatedModel? in
        switch state {
        case .loggedIn(let client):
          return AuthenticatedModel(client: client, accountModel: accountModel)
          
        case .loggedOut:
          return nil
        }
      }
      .assign(to: &$authenticatedModel)
    
  }
  
}
