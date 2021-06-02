//
//  ViewRouter.swift
//  swift-ui-base
//
//  Created by Germán Stábile on 3/13/20.
//  Copyright © 2020 Rootstrap. All rights reserved.
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
