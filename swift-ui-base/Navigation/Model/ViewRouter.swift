//
//  ViewRouter.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import Foundation
import Combine

enum Roots:Hashable {
	static func == (lhs: Roots, rhs: Roots) -> Bool {
		true
	}
	
  case home
  case signIn
  case otp(String)
  case profile
  case list
}

class ViewRouter: ObservableObject {
  @Published var currentRoot: Roots = SessionManager.isValidSession ? .profile : .signIn
  
  static let shared = ViewRouter()
  
  fileprivate init() { }
}
