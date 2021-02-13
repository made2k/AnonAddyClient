//
//  AliasModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/18/21.
//

import AnonAddyAPI
import Combine
import Foundation

final class AliasModel: ObservableObject, Identifiable {
  
  let id: UUID
  
  let aliasLoader: AliasLoader
  
  @Published private(set) var alias: Alias
  @Published var active: Bool
  @Published var description: String?
  
  var isUpdating: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
    
  init(_ alias: Alias, loader: AliasLoader) {
    self.id = alias.id
    self.alias = alias
    self.aliasLoader = loader
    
    self.active = alias.active
    
    setupCombine()
  }
  
  private func setupCombine() {
    
    $active
      .dropFirst()
      .sink(receiveValue: updateActiveState)
      .store(in: &cancellables)
    
    $alias
      .first()
      .map(\.description)
      .assign(to: &$description)
    
  }
  
  func updateDescription(_ newValue: String?) {

    var string: String? = newValue
    if newValue?.isEmpty == true { string = nil }
    
    aliasLoader.update(alias: alias, description: string)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          print("completion")
        },
        receiveValue: { [weak self] alias in
          self?.alias = alias
        }
      )
      .store(in: &cancellables)
  
  }
  
  private func updateActiveState(_ isActive: Bool) {
    
    guard isUpdating == false else { return }
    guard isActive != active else { return }
    
    if isActive {
      activate()
    } else {
      deactivate()
    }
    
  }
  
  private func activate() {
    
    isUpdating = true
    
    aliasLoader.activate(alias: alias)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        
        switch completion {
        case .failure:
          self?.active = false
          
        default:
          break
        }
        
        self?.isUpdating = false
        
      } receiveValue: { [weak self] alias in
        self?.alias = alias
      }
      .store(in: &cancellables)

    
  }
  
  private func deactivate() {
    
    isUpdating = true
    
    aliasLoader.deactivate(alias: alias)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        
        switch completion {
        case .failure:
          self?.active = true
          
        default:
          break
        }
        
        self?.isUpdating = false
        
      } receiveValue: {_ in }
      .store(in: &cancellables)
  }
  
}
