//
//  BaseService.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//
import Foundation
import UIKit
import Combine

class AuthenticationServices {
  
  fileprivate static let usersUrl = "/users/"
  fileprivate static let currentUserUrl = "/user/"
	
	class func loginwithCombine(_ email: String,
					 password: String,
					 success: @escaping () -> Void,
					 failure: @escaping (_ error: Error) -> Void) -> Future<User,Error> {
	  let url = usersUrl + "sign_in"
	  let parameters = [
		"user": [
		  "email": email,
		  "password": password
		]
	  ]
	return Future<User,Error> { promise in

	  APIClient.request(.post, url: url, params: parameters, success: { response, headers in
		AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
		promise(.success(User.init(id: 1, username: "aa", email: "bb")))
		success()
	  }, failure: { error in
		failure(error)
	  })
	}
}
  
  class func login(_ email: String,
                   password: String,
                   success: @escaping () -> Void,
                   failure: @escaping (_ error: Error) -> Void) {
    let url = usersUrl + "sign_in"
    let parameters = [
      "user": [
        "email": email,
        "password": password
      ]
    ]
    APIClient.request(.post, url: url, params: parameters, success: { response, headers in
      AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
      success()
    }, failure: { error in
      failure(error)
    })
  }
  
  //Multi part upload example
  //TODO: rails base backend not supporting multipart uploads yet
  class func signup(_ email: String,
                    password: String,
                    avatar: UIImage,
                    success: @escaping (_ user: User?) -> Void,
                    failure: @escaping (_ error: Error) -> Void) {
    let parameters = [
      "user": [
        "email": email,
        "password": password,
        "password_confirmation": password
      ]
    ]
    
    guard let picData = avatar.jpegData(compressionQuality: 0.75) else {
      failure(App.error(
        domain: .parsing,
        code: 1000,
        localizedDescription: "Could not parse image"
      ))
      return
    }
    let image = MultipartMedia(key: "user[avatar]", data: picData)
    //Mixed base64 encoded and multipart images are supported in [MultipartMedia] param:
    //Example: let image2 = Base64Media(key: "user[image]", data: picData) Then: media [image, image2]
    APIClient.multipartRequest(
      url: usersUrl,
      params: parameters,
      paramsRootKey: "",
      media: [image],
      success: { response, headers in
        AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
        success(UserDataManager.currentUser)
      },
      failure: failure
    )
  }
	//Example method that uploads base64 encoded image.
	class func getOtp(_ phoneNumber: String,
					  success: @escaping (_ otp: String?) -> Void,
					  failure: @escaping (_ error: Error) -> Void) {
		let _: [String: Any] = [
			"phoneNumber": phoneNumber,
		]
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			print("Async after 2 seconds")
			success("1234")
		}
		
//		APIClient.request(
//			.post,
//			url: usersUrl,
//			params: userParameters,
//			success: { response, headers in
//				AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
//				success(UserDataManager.currentUser)
//			},
//			failure: failure
//		)
	}
	//----------*****************************************
	//Example method that uploads base64 encoded image.
	class func getOtpWithCombine(_ phoneNumber: String) ->  Future<String,Error>{
		let param: [String: Any] = [
			"phoneNumber": phoneNumber,
		]
//		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//			print("Async after 2 seconds")
//			success("1234")
//		}
		return Future<String,Error> { promise in

		APIClient.request(
			.post,
			url: usersUrl,
			params: param,
			success: { response, headers in
				AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
//				success(UserDataManager.currentUser)
				promise(.success("1234"))
			},
			failure: { error in
				promise(.success("1234"))
//				failure(error)
              })
	  }
	}
	
	class func validateOtp(_ otp: String,
						   phoneNumber:String,
					  success: @escaping (_ otp: Bool?) -> Void,
					  failure: @escaping (_ error: Error) -> Void) {
		let _: [String: Any] = [
			"phoneNumber": phoneNumber,
			"otp":otp
		]
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			print("Async after 2 seconds")
			success(true)
		}
		
//		APIClient.request(
//			.post,
//			url: usersUrl,
//			params: userParameters,
//			success: { response, headers in
//				AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
//				success(UserDataManager.currentUser)
//			},
//			failure: failure
//		)
	}
  //Example method that uploads base64 encoded image.
  class func signup(_ phoneNumber: String,
                    success: @escaping (_ user: User?) -> Void,
                    failure: @escaping (_ error: Error) -> Void) {
	let userParameters: [String: Any] = [
      "phoneNumber": phoneNumber,
    ]
	
    let parameters = [
      "user": userParameters
    ]
    
    APIClient.request(
      .post,
      url: usersUrl,
      params: parameters,
      success: { response, headers in
        AuthenticationServices.saveUserSession(fromResponse: response, headers: headers)
        success(UserDataManager.currentUser)
      },
      failure: failure
    )
  }
  
  class func logout(
    success: @escaping () -> Void = {},
    failure: @escaping (_ error: Error) -> Void = { _ in }
  ) {
    let url = "\(usersUrl)sign_out"
    APIClient.request(
      .delete,
      url: url,
      success: { _, _ in
        deleteSession()
        success()
      },
      failure: failure
    )
  }
  
  class func deleteAccount(
    success: @escaping () -> Void = {},
    failure: @escaping (_ error: Error) -> Void = { _ in }
  ) {
    let url = "\(currentUserUrl)delete_account"
    APIClient.request(
      .delete,
      url: url,
      success: { _, _ in
        deleteSession()
        success()
      },
      failure: failure
    )
  }
  
  class func deleteSession() {
    UserDataManager.deleteUser()
    SessionManager.deleteSession()
  }
  
  class func saveUserSession(
    fromResponse response: [String: Any],
    headers: [AnyHashable: Any]
  ) {
    UserDataManager.currentUser = User(
      dictionary: response["user"] as? [String: Any] ?? [:]
    )
    if let headers = headers as? [String: Any] {
      SessionManager.currentSession = Session(headers: headers)
    }
  }
}
