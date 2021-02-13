//
//  LoginViewModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/7/21.
//

import AnonAddyAPI
import Combine
import Foundation

class LoginViewModel: ObservableObject {
  
  enum State {
    case idle
    case loading
    case error
  }
  
  let accountModel: AccountModel
  
  @Published private(set) var state = State.idle
  @Published var accessToken: String = ""
  @Published private(set) var canLogin: Bool = false
  @Published var showErrorAlert: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(accountModel: AccountModel) {
    
    self.accountModel = accountModel
    
    $accessToken
      .map(\.isEmpty)
      .map(!)
      .assign(to: &$canLogin)
    
    $state
      .map { $0 == .error }
      .assign(to: &$showErrorAlert)
    
  }
  
  func login() {
    
    state = .loading
    
    accountModel.login(with: self.accessToken)
      .subscribe(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          
          switch completion {
          case .failure:
            self?.state = .error
            
          case .finished:
            self?.resetState()
          }
          
        }, receiveValue: { _ in }
      )
      .store(in: &cancellables)
    
  }
  
  func resetState() {
    accessToken = ""
    state = .idle
  }

}
