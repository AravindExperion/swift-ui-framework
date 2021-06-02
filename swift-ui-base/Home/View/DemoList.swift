//
//  DemoList.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import SwiftUI
import MobileCoreServices

struct Item: Identifiable {
    let id = UUID()
    let title: String
}

struct DemoList: View {
	@ObservedObject var viewModel = HomeViewModel()
    @State private var editMode = EditMode.inactive
    private static var count = 0

    var body: some View {
        NavigationView {
			if #available(iOS 14.0, *) {
//				Text("\(viewModel.count)")
				List {
					ForEach(viewModel.items) { item in
						Text(item.title)
					}
					.onDelete(perform: onDelete)
					.onMove(perform: onMove)
				}
				.navigationBarTitle("List \(viewModel.count)")
				.toolbar {
					ToolbarItem(placement: .automatic) {
						EditButton()
					}
					ToolbarItem(placement: .navigationBarLeading) {
						addButton
					}
					ToolbarItem(placement: .principal) {
						Button("Profile") {
							ViewRouter.shared.currentRoot = .profile
						}
					}
				}
				.environment(\.editMode, $editMode)
			} else {
				// Fallback on earlier versions
			}
        }.onAppear(){
			viewModel.loadAllData()
	 }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    private func onDelete(offsets: IndexSet) {
		viewModel.onDelete(offsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
		viewModel.onMove(source: source, destination: destination)
    }
    
    private func onAdd() {
		viewModel.onAdd()
    }
}

struct DemoList_Previews: PreviewProvider {
	static var previews: some View {
		DemoList()
	}
}
