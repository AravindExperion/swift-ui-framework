//
//  UserServices.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import Foundation

class UserServices {
  class func getMyProfile(
    success: @escaping (_ user: User) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    APIClient.request(
      .get,
      url: "/user/profile",
      success: { response, _ in
        guard
          let userDictionary = response["user"] as? [String: Any],
          let user = User(dictionary: userDictionary)
        else {
          failure(App.error(
            domain: .parsing,
            localizedDescription: "Could not parse a valid user".localized
          ))
          return
        }
        
        UserDataManager.currentUser = user
        success(user)
      },
      failure: failure
    )
  }
}
