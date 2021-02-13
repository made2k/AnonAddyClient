//
//  ActivityIndicatorView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/8/21.
//

import Foundation
import SwiftUI

/**
 Simple activity indicator that blocks the user from accessing
 views under it.
 */
struct ActivityIndicatorView: View {
  
  var body: some View {
    
    ZStack {
      
      Color(.systemBackground)
        .ignoresSafeArea()
        .opacity(0.1)
        .disabled(true)
      
      ZStack {
        
        Color(.systemBackground)
        
        ActivityIndicator(animate: .constant(true))
          .padding(64)
        
      }
      .fixedSize()
      .cornerRadius(20)
      .shadow(radius: 10)
      
    }
  }
  
}

private struct ActivityIndicator: UIViewRepresentable {
  
  @Binding var animate: Bool
  
  func makeUIView(context: Context) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: .large)
  }
  
  func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
    uiView.startAnimating()
  }
  
}
