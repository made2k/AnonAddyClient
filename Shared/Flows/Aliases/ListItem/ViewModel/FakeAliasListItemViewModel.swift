//
//  FakeAliasListItemViewModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/18/21.
//

import AnonAddyAPI
import Foundation

final class FakeAliasListItemViewModel: AliasListItemViewModelProtocol {
  var model: AliasModel = AliasModel(.random(), loader: Client.preview.aliasLoader())
  var ageDescription: String { "\(Int.random(in: 1..<5)) months" }
}
