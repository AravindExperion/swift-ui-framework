//
//  SignUpView.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
  @ObservedObject var viewModel = SignUpViewModel()
  
  var body: some View {
    ZStack {
      ActivityIndicatorView(isAnimating: $viewModel.isLoading, style: .medium)
      
      VStack {
        Text("Sign Up")
          .modifier(MainTitle())
        
        Spacer()
        
        VStack(spacing: 20) {
          TextFieldView(fieldData: $viewModel.phoneData)
//          TextFieldView(fieldData: $viewModel.passwordData)
//          TextFieldView(fieldData: $viewModel.confirmPasswordData)
        }
        Spacer()
        
        Button(action: signUpButtonTapped, label: {
          Text("Sign Up")
            .font(.headline)
        })
          .accessibility(identifier: "SignUpButton")
          .disabled(!viewModel.isValidData)
        
        Spacer()
      }
      .disabled(viewModel.isLoading)
      .blur(radius: viewModel.isLoading ? 3 : 0)
      .alert(isPresented: $viewModel.errored) {
        Alert(title: Text("Oops"),
              message: Text(viewModel.error),
              dismissButton: .default(Text("Got it!")))
      }
    }
  }
  
  func signUpButtonTapped() {
    viewModel.attemptSingUpComobine()
  }
}

struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpView()
  }
}
