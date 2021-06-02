//
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import UIKit

class SessionManager: NSObject {
  
  static private let userDefaultSessionKey = "swift-ui-base-session"
  
  static var currentSession: Session? {
    get {
      if
        let data = UserDefaults.standard.data(forKey: userDefaultSessionKey),
        let session = try? JSONDecoder().decode(Session.self, from: data)
      {
        return session
      }
      return nil
    }
    
    set {
      let session = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(session, forKey: userDefaultSessionKey)
    }
  }
  
  class func deleteSession() {
    UserDefaults.standard.removeObject(forKey: userDefaultSessionKey)
  }
  
  static var isValidSession: Bool {
    if
      let session = currentSession,
      let uid = session.uid,
      let token = session.accessToken,
      let client = session.client
    {
      return !uid.isEmpty && !token.isEmpty && !client.isEmpty
    }
    
    return false
  }
}
