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
  
  @ObservedObject private var viewModel = LoginViewModel()
  
  var body: some View {
    
    ZStack {
      
      Color.brandBackground
        .ignoresSafeArea()
      
      VStack {
        Image.Custom.logoFull
          .padding(.bottom, 36)
        
        TextField(strings.accessTokenPlaceholder, text: $viewModel.accessToken)
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
      
      switch viewModel.state {
      case .loading:
        ActivityIndicatorView()
        
      default:
        Color.clear
      }
      
    }
    .alert(isPresented: $viewModel.showErrorAlert, content: {
      Alert(
        title: Text("Bad login"),
        message: nil,
        dismissButton: Alert.Button.default(
          Text("Try Again"),
          action: {
            viewModel.resetState()
          })
      )
    })
    
  }
  
  private func submit() {
    viewModel.login()
  }
  
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
