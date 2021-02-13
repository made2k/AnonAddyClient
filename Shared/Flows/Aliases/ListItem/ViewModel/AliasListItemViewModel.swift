//
//  AliasListItemViewModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/18/21.
//

import AnonAddyAPI
import Combine
import Foundation
import SwiftUI

final class AliasListItemViewModel: AliasListItemViewModelProtocol {

  @ObservedObject private(set) var model: AliasModel
  
  var ageDescription: String { model.alias.createdAt.ageDescription() }
  
  init(_ model: AliasModel) {
    self.model = model
  }
  
}
