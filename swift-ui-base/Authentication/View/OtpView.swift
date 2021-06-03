//
//  OtpView.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import SwiftUI

struct OtpView: View {
 @ObservedObject var viewModel: OtpViewModel
 var mobileNumber: String = ""
	init(mobileNumber:String) {
		viewModel = OtpViewModel(mobileNumber:mobileNumber)
	}
 var body: some View {
   ZStack {
	 ActivityIndicatorView(isAnimating: $viewModel.isLoading, style: .medium)
	 
	 VStack {
	   Text("OTP Validation")
		 .modifier(MainTitle())
	   
	   Spacer()
		Text(viewModel.mobileNumber)
		  .modifier(MainTitle())
	   VStack(spacing: 20) {
		 TextFieldView(fieldData: $viewModel.otpData)
//          TextFieldView(fieldData: $viewModel.passwordData)
//          TextFieldView(fieldData: $viewModel.confirmPasswordData)
	   }
	   Spacer()
	   
	   Button(action: verifyTapped, label: {
		 Text("Verify Otp")
		   .font(.headline)
	   })
		 .disabled(!viewModel.isValidData)
		
		Button(action: resendTapped, label: {
		  Text("Resend  Otp")
			.font(.headline)
		})
	   
	   Spacer()
	 }
	 .disabled(viewModel.isLoading)
	 .blur(radius: viewModel.isLoading ? 3 : 0)
	 .alert(isPresented: $viewModel.errored) {
	   Alert(title: Text("Oops"),
			 message: Text(viewModel.error),
			 dismissButton: .default(Text("Got it!")))
	 }
   }
 }
 
 func verifyTapped() {
   viewModel.attemptOtpValidation()
 }
 func resendTapped() {
   viewModel.attemptOtpValidation()
 }
}

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
		OtpView(mobileNumber: "1234")
    }
}
