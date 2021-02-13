//
//  AccountModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/14/21.
//

import AnonAddyAPI
import Combine
import CombineExt
import KeychainAccess


/// Model representative of the users account.
final class AccountModel: ObservableObject {
  
  enum State {
    case loggedIn(_ client: Client)
    case loggedOut
  }
  
  static let shared: AccountModel = AccountModel()
  private static let tokenKey: String = "accesstoken"
  
  @Published private(set) var state: State
  @Published private(set) var account: Account?
  
  private let keychain: Keychain
  private var client: Client? {
    switch state {
    case .loggedIn(let client):
      return client
      
    case .loggedOut:
      return nil
    }
  }
  private var loader: AccountLoader? { client?.accountLoader() }
  
  private var cancellables: Set<AnyCancellable> = []
  
  // This is a singleton to avoid conflicts with keychain and state.
  // If multiple instaces were created, one signing would would
  // not affect other instances of this model until app restart.
  private init() {

    // Without a bundle id we can't access our keychain and can't use
    // the app. Fast fail.
    guard let bundleId: String = Bundle.main.bundleIdentifier else {
      preconditionFailure("No bundle ID unable to load keychain")
    }
    
    let service: String = "\(bundleId).keychain"
    self.keychain = Keychain(service: service)
    
    // If we have a saved auth token, set our state to logged in
    if let savedToken: String = keychain[string: Self.tokenKey] {
      let accessToken: AccessToken = AccessToken(rawValue: savedToken)
      let client: Client = Client(token: accessToken)
      self.state = .loggedIn(client)
      
    } else {
      self.state = .loggedOut
    }
      
  }
  
  // MARK: - Public functions

  /**
   Load the users account with the signed in user.
   
   When an account is loaded it will assign the value to the account property.
   If there is an auth error while attempting to load the account (such as an invalid token)
   this class will invalidated the saved credential.
   
   - Note:
   If we do not have an auth token, this function does nothing.
   */
  func loadAccount() {
    
    guard let loader = loader else { return }
    
    let fetch = loader.loadAccount()
      .materialize()
      .first()
    
    // Handle failures
    fetch.failures()
      .sink { [weak self] (error: APIError) in
        self?.handleAccountError(error)
      }
      .store(in: &cancellables)
    
    // Handle success
    fetch.values()
      .asOptional()
      .assign(to: &$account)
      
  }
  
  /**
   Attempt to log in with a given key.
   
   When log in succeeds the access token is saved in the users keychain
   so that future launches of the application will stay logged in. The state
   of this class is also updated on a successful log in to represent the newly
   authenticated user.
   
   - Parameters:
      - key: The auth token generated on the web to authenticate against.
   
   - Returns: A Publisher containing the loaded account on success.
   */
  func login(with key: String) -> AnyPublisher<Account, APIError> {
    
    // Create a temporary client to attempt the log in process.
    let token = AccessToken(rawValue: key)
    let client = Client(token: token)
    
    let publisher = client.accountLoader().loadAccount()
    
    // We only pay attention to the successful case here.
    // On a failure, it'll be up to the calling class to handle
    // the error.
    publisher
      .materialize()
      .values()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] (account: Account) in
        self?.account = account
        self?.keychain[string: Self.tokenKey] = key
        self?.state = .loggedIn(client)
      }
      .store(in: &cancellables)
    
    return publisher
  }
  
  /**
   Attempt to remove the stored access token from the keychain.
   
   - Throws: An error if there was a failure removing the item from the keychain.
   */
  func logout() throws {
    
    do {
      try keychain.remove(Self.tokenKey)
      state = .loggedOut
      
    } catch {
      // Log the error and rethrow
      print(error)
      throw error
    }
    
  }
  
  // MARK: - Private functions
  
  private func handleAccountError(_ error: APIError) {
    
    // If our token is no longer valid, attempt to log out.
    if case APIError.unauthenticated = error {
      try? logout()
    }
    
  }
  
}
