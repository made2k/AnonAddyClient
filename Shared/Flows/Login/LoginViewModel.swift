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
  
  @Published private(set) var state = State.idle
  @Published var accessToken: String = ""
  @Published private(set) var canLogin: Bool = false
  @Published var showErrorAlert: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    
    $accessToken
      .map(\.isEmpty)
      .map(!)
      .assign(to: &$canLogin)
    
    $state
      .map { $0 == .error }
      .assign(to: &$showErrorAlert)
    
  }
  
  func login() {
    let accessToken: AccessToken = AccessToken(rawValue: self.accessToken)
    // Create a temporary client to validate our token
    let client = Client(token: accessToken)
    let loader = AccountLoader(client: client)
    
    state = .loading
    
    loader.loadAccount()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] (completion) in
                
        switch completion {
        case .failure(let error):
          self?.loginFailed(error)
          
        default:
          break
        }
        
      } receiveValue: { [weak self] _ in
        self?.loginSuccess(client)
      }
      .store(in: &cancellables)
    
  }
  
  func resetState() {
    accessToken = ""
    state = .idle
  }
  
  private func loginSuccess(_ client: Client) {
    state = .idle
    SessionManager.shared.client = client
    print("login success")
  }
  
  private func loginFailed(_ error: APIError) {
    state = .error
    print("login failed")
  }
  
}
