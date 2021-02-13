//
//  StackedListItemView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/14/21.
//

import SwiftUI

/**
 The StackedListItemView is a common way to present stacked
 data. That is, a title and a value underneath.
 
 Example:
 ```
 Sent
   24
 ```
 */
struct StackedListItemView: View {
  
  let topText: String
  let bottomText: String
  
  var body: some View {

    VStack(alignment: .trailing) {
      
      Text(topText)
        .font(.headline)
        .foregroundColor(Color(.secondaryLabel))
        .lineLimit(1)
      
      Text(bottomText)
        .font(.body)
        .lineLimit(1)
      
    }

  }
}

struct StackedListItemView_Previews: PreviewProvider {
  static var previews: some View {
    StackedListItemView(topText: "Blocked", bottomText: "24")
  }
}
