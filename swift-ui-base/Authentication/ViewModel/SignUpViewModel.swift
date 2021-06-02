//
//  SignUpViewModel.swift
//  swift-ui-base
//
//  Created by Germán Stábile on 4/3/20.
//  Copyright © 2020 Rootstrap. All rights reserved.
//

import Foundation
import UIKit
import Combine
class SignUpViewModel: ObservableObject, Identifiable {
	
	@Published var phoneData = TextFieldData(
		title: "Phone Number",
		validationType: .phone,
		errorMessage: "Please enter a valid mobile number"
	)
	
	@Published var isLoading = false
	@Published var errored = false
	var error: String = ""
	private var subscriptions = Set<AnyCancellable>()
	private let loadTrigger = PassthroughSubject<[String: Any], Never>()


	
	var isValidData: Bool {
		return [phoneData].allSatisfy { $0.isValid }
	}
	
	func attemptSingUp() {
		isLoading = true
		AuthenticationServices.getOtp(
			phoneData.value,
			
			success: { [weak self] _ in
				self?.isLoading = false
				ViewRouter.shared.currentRoot = .otp(self?.phoneData.value ?? "")
			},
			failure: { [weak self] error in
				self?.isLoading = false
				self?.errored = true
				self?.error = error.localizedDescription
			})
	}
	func attemptSingUpComobine() {
		isLoading = true
		let result = AuthenticationServices.getOtpWithCombine(phoneData.value)
		result.receive(on:DispatchQueue.main)
			.sink(receiveCompletion: { (completion) in
				print(completion)
			}) { [weak self] (dataObj) in
				self?.isLoading = false
				print(dataObj)
			}
			.store(in: &subscriptions)
	}
}


