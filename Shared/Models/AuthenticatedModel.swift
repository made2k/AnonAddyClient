//
//  AuthenticatedModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/15/21.
//

import AnonAddyAPI
import Foundation

/**
 This model is a top level model that contains other models that
 require an authenticated user to be used.
 */
final class AuthenticatedModel: ObservableObject {
  
  let accountModel: AccountModel
  let aliasesModel: AliasesModel
  
  private let client: Client
  
  init(client: Client, accountModel: AccountModel) {
    self.client = client
    self.accountModel = accountModel
    self.aliasesModel = AliasesModel(client.aliasLoader())
  }
  
}
