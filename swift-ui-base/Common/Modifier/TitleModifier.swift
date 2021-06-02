//
//  TitleModifier.swift
//  swift-ui-base
//
//  Created by Aravind on 01/06/21.
//  Copyright © 2021 Rootstrap. All rights reserved.
//

import SwiftUI

struct MainTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding()
      .foregroundColor(.darkGray)
      .font(.largeTitle)
  }
}

struct SubTitle: ViewModifier {
  func body(content: Content) -> some View {
	content
	  .padding()
	  .foregroundColor(.darkGray)
		.font(.headline)
  }
}
struct MainTitle_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Text("Hello, World!")
        .previewLayout(.sizeThatFits)
      
      Text("Hello, World!")
        .modifier(MainTitle())
        .previewLayout(.sizeThatFits)
    }
  }
}
