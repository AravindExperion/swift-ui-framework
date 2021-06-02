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

class HomeServices {
  
	class func getListData() -> Future<[Item],Error>{
		return Future<[Item],Error> { promise in
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				print("Async after 2 seconds")
				var items:[Item] = []
				items.append(Item(title: "Item #0"))
				items.append(Item(title: "Item #1"))
				items.append(Item(title: "Item #2"))
				promise(.success(items))
			}
		}
	}
	
	class func getListDataCount() -> Future<String,Error>{
		return Future<String,Error> { promise in
			DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
				print("Async after 4 seconds")
				promise(.success("3"))
			}
		}
	}

}
