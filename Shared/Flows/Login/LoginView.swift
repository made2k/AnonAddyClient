//
//  LoginView.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/7/21.
//

import AnonAddyAPI
import SwiftUI

struct LoginView: View {
  
  private let strings = Strings.Login.self
  
  @ObservedObject var viewModel: LoginViewModel
  
  var body: some View {
    
    ZStack {
      
      Color.brandBackground
        .ignoresSafeArea()
      
      VStack {
        Image.Custom.logoFull
          .padding(.bottom, 36)
        
        TextField(
          strings.accessTokenPlaceholder,
          text: $viewModel.accessToken,
          onCommit: textCommit
        )
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(4.0)
        
        Text(strings.accessTokenInstructions)
          .font(.footnote)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          .padding(.bottom, 32)
        
        Button(action: submit) {
          HStack(alignment: .center) {
            Spacer()
            Text(strings.loginButtonTitle).foregroundColor(Color.brandButtonText).bold()
            Spacer()
          }
        }
        .buttonStyle(DisabledButtonStyle())
        .padding()
        .background(Color.brandButtonBackground)
        .cornerRadius(4.0)
        .disabled(viewModel.canLogin == false)
        
      }
      .padding()
      .frame(maxWidth: 500)
      
      switch viewModel.state {
      case .loading:
        ActivityIndicatorView()
        
      default:
        Color.clear
      }
      
    }
    .alert(isPresented: $viewModel.showErrorAlert, content: {
      Alert(
        title: Text(Strings.Login.loginErrorTitle),
        message: nil,
        dismissButton: Alert.Button.default(
          Text(Strings.Login.loginErrorButton),
          action: {
            viewModel.resetState()
          })
      )
    })
    
  }
  
  private func textCommit() {
    guard viewModel.canLogin else { return }
    submit()
  }
  
  private func submit() {
    viewModel.login()
  }
  
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView(viewModel: LoginViewModel(accountModel: AppModel.shared.accountModel))
  }
}
