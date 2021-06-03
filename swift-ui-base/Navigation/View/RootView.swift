//
//  NavigationView.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import SwiftUI

struct RootView: View {
	
  @EnvironmentObject var router: ViewRouter
  
  var body: some View {
    VStack {
      containedView()
        .id(router.currentRoot)
        .transition(.slide).animation(.linear(duration: 0.2))
    }
  }
  
  func containedView() -> AnyView {
    switch router.currentRoot {
    case .profile:
      return AnyView(ProfileView())
	case .otp(let mobileNumber):
	  return AnyView(OtpView(mobileNumber: mobileNumber))
	case .list:
		return AnyView(DemoList())

    default:
      return AnyView(SignUpView())
    }
  }
}
