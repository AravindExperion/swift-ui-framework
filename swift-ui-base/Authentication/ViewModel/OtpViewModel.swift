//
//  OtpViewModel.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import Foundation

class OtpViewModel: ObservableObject, Identifiable {
	@Published var otpData = TextFieldData(
	  title: "Otp",
	  validationType: .nonEmpty,
	  errorMessage: "Please enter a valid otp"
	)

  @Published var isLoading = false
  @Published var errored = false
  var error: String = ""
  var mobileNumber = ""
	
	init(mobileNumber:String) {
		otpData.validationType = .custom(isValid: validOtp)
		self.mobileNumber = mobileNumber
  //    passwordData.validationType = .custom(isValid: passwordsMatch)
	}
  
  var isValidData: Bool {
	return [otpData].allSatisfy { $0.isValid }
  }
	
	func validOtp() -> Bool{
		guard !otpData.isEmpty else { return false }
		let valid = otpData.value.count > 3
		return valid
	}
  
  func attemptOtpValidation() {
	isLoading = true
	AuthenticationServices.validateOtp(
		otpData.value, phoneNumber: mobileNumber,

	  success: { [weak self] _ in
		self?.isLoading = false
		ViewRouter.shared.currentRoot = .list
	  },
	  failure: { [weak self] error in
		self?.isLoading = false
		self?.errored = true
		self?.error = error.localizedDescription
	})
  }
}
