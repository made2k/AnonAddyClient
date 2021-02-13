//
//  AliasListItemViewModelProtocol.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/18/21.
//

import Foundation

protocol AliasListItemViewModelProtocol: ObservableObject {
  var model: AliasModel { get }
  var ageDescription: String { get }
}
