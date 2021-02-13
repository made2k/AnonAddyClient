//
//  AliasesModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/15/21.
//

import AnonAddyAPI
import Foundation

/// Model is responsible for the list of the users aliases.
final class AliasesModel: ObservableObject {
  
  @Published private(set) var aliases: [AliasModel] = []
  
  private let loader: AliasLoader
  
  init(_ loader: AliasLoader) {
    self.loader = loader
  }
  
  /// Load the users aliases and store them in the aliases property.
  func loadAllAliases() {

    loader.loadAliases()
      .materialize()
      .values()
      .mapMany { [loader] in AliasModel($0, loader: loader) }
      .receive(on: DispatchQueue.main)
      .assign(to: &$aliases)
    
  }
  
}

// MARK: - Previewing

extension AliasesModel {
  
  static var preview: AliasesModel {
    let client = Client.preview
    let model = AliasesModel(client.aliasLoader())
    
    var aliasModels: [AliasModel] = []
    for _ in 0..<Int.random(in: 0..<10) {
      aliasModels.append(AliasModel(Alias.random(), loader: client.aliasLoader()))
    }

    model.aliases = aliasModels
    
    return model
  }
  
}
