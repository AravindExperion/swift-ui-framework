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
    @State private var items: [Item] = []
    @State private var editMode = EditMode.inactive
    private static var count = 0

    var body: some View {
        NavigationView {
			if #available(iOS 14.0, *) {
				List {
					ForEach(items) { item in
						Text(item.title)
					}
					.onDelete(perform: onDelete)
					.onMove(perform: onMove)
				}
				.navigationBarTitle("List")
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
//				.navigationBarItems(leading: EditButton(), trailing: addButton)
				.environment(\.editMode, $editMode)
			} else {
				// Fallback on earlier versions
			}
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
        items.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    
    
    private func onAdd() {
        items.append(Item(title: "Item #\(Self.count)"))
        Self.count += 1
    }
}

struct DemoList_Previews: PreviewProvider {
	static var previews: some View {
		DemoList()
	}
}
