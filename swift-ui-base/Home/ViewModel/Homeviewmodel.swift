//
//  SignUpViewModel.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import Foundation
import UIKit
import Combine
class HomeViewModel: ObservableObject, Identifiable {
	@Published var items: [Item] = []
	var count = 0
	
	@Published var isLoading = false
	@Published var errored = false
	var error: String = ""
	private var subscriptions = Set<AnyCancellable>()
	private let loadTrigger = PassthroughSubject<[String: Any], Never>()

	func loadAllData() {
		isLoading = true
		let result1  = HomeServices.getListData()
		let result2  = HomeServices.getListDataCount()
		let allResult  = Publishers.Zip(result1,result2)
		allResult.receive(on:DispatchQueue.main)
			.sink(receiveCompletion: { (completion) in
				print(completion)
			}) { [weak self] (result1,result2) in
				self?.isLoading = false
				self?.items = result1
				self?.count = Int(result2) ?? 0
				print(result1)
				print(result2)
			}
			.store(in: &subscriptions)
	}
	
	func onDelete(offsets: IndexSet) {
		items.remove(atOffsets: offsets)
	}
	
	func onMove(source: IndexSet, destination: Int) {
		items.move(fromOffsets: source, toOffset: destination)
	}
	
	func onAdd() {
		items.append(Item(title: "Item #\(self.count)"))
		self.count += 1
	}
}


