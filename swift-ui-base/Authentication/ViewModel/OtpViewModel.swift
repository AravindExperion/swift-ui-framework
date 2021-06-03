//
//  OtpViewModel.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//
import Foundation
import Combine

class OtpViewModel: ObservableObject, Identifiable {
	private var subscriptions = Set<AnyCancellable>()
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
	isLoading = true
	let result = AuthenticationServices.validateOtpWithCombine(otpData.value, phoneNumber: mobileNumber)
	result.receive(on:DispatchQueue.main)
		.sink(receiveCompletion: { (completion) in
			print(completion)
		}) { [weak self] (user) in
			self?.isLoading = false
			if (user.role == .admin){
				ViewRouter.shared.currentRoot = .list
			}
			else {
				ViewRouter.shared.currentRoot = .profile
			}
			print(user)
		}
		.store(in: &subscriptions)
  }
}
