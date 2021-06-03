//
//  User.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import Foundation

enum userRoles:Int{
	case admin
	case user
}

struct User: Codable {
  var id: Int
  var username: String
  var email: String
  var imageURL: URL?
  var role:userRoles = .admin
  
  private enum CodingKeys: String, CodingKey {
    case id
    case username
    case email
    case imageURL = "profile_picture"
  }
  
  init?(dictionary: [String: Any]) {
    guard
      let id = dictionary[CodingKeys.id.rawValue] as? Int,
      let username = dictionary[CodingKeys.username.rawValue] as? String,
      let email = dictionary[CodingKeys.email.rawValue] as? String
    else {
        return nil
    }
    
    self.id = id
    self.username = username
    self.email = email
    self.imageURL = URL(
      string: dictionary[CodingKeys.imageURL.rawValue] as? String ?? ""
    )
  }
  
  init(id: Int, username: String, email: String, imageURL: URL? = nil) {
    self.id = id
    self.username = username
    self.email = email
    self.imageURL = imageURL
  }
}
