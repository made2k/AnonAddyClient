//
//  AliasEmailView.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/14/21.
//

import AnonAddyAPI
import SwiftUI

/**
 A view with the common style of a users email alias.
 That is, a bolded local part and a standard body domain.
 */
struct AliasEmailView: View {
  
  let email: Email
  
  var body: some View {

    HStack(alignment: .firstTextBaseline, spacing: 0) {
      
      Text(email.localPart)
        .fontWeight(.semibold)
        .layoutPriority(0)
      
      Text("@\(email.domain.rawValue)")
        .fontWeight(.light)
        .layoutPriority(1)
      
    }
    .lineLimit(1)

  }
}

struct AliasEmailView_Previews: PreviewProvider {
  static var previews: some View {
    AliasEmailView(email: Email(rawValue: "exampleEmail@example.com")!)
  }
}
