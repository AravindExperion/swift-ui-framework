//
//  ContentView.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        
        Text("Welcome to RS SwiftUI base!")
          .modifier(MainTitle())
        
        Spacer()
        
        NavigationLink(destination: LoginView()) {
          Text("Log In")
            .frame(width: 300, height: 50)
            .font(.subheadline)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.bottom, 20)
        }
        .accessibility(identifier: "GoToLoginLink")
        
        NavigationLink(destination: SignUpView()) {
          Text("Don't have an account? Lets create one! ►")
            .frame(width: 300, height: 50)
            .font(.subheadline)
            .foregroundColor(.gray)
            .cornerRadius(8)
        }
        .accessibility(identifier: "GoToSignUpLink")
  
        Spacer()
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
