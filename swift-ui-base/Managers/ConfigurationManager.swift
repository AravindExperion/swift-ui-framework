//
//  ConfigurationManager.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//
import Foundation

class ConfigurationManager: NSObject {

  class func getValue(
    for key: String,
    on propertyList: String = "ThirdPartyKeys"
  ) -> String? {
    if
      let path = Bundle.main.path(forResource: propertyList, ofType: "plist"),
      let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
    {
      if let configDict = dict[key] as? [String: AnyObject] {
        let key = Bundle.main.object(
          forInfoDictionaryKey: "ConfigurationName"
        ) as? String ?? ""
        return configDict[key] as? String
      } else if let value = dict[key] as? String {
        return value
      }
    }
    
    print("""
      \(propertyList).plist NOT FOUND -
      Please check your project configuration in: \n https://github.com/rootstrap/swift-ui-base
    """)
    return nil
  }
}
