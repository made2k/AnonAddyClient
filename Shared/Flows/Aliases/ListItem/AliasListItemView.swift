//
//  AliasListItemView.swift
//  AnonAddyAPI
//
//  Created by Zach McGaughey on 2/12/21.
//

import AnonAddyAPI
import SwiftUI

struct AliasListItemView<ViewModel: AliasListItemViewModelProtocol>: View {
  
  @Environment(\.horizontalSizeClass) var horizontalSizeClass

  @ObservedObject var viewModel: ViewModel
  
  var body: some View {
    
    switch horizontalSizeClass {
    case .compact:
      compactLayout
      
    default:
      regularLayout
    }
    
  }
  
  private var compactLayout: some View {
    
    VStack(alignment: .leading) {
      AliasEmailView(email: viewModel.model.alias.email)
      
      HStack(alignment: .firstTextBaseline) {
        Image(systemName: "clock.fill")
          .foregroundColor(Color(.secondaryLabel))
      Text(Strings.AliasListItem.createdInline(viewModel.ageDescription))
        .font(.subheadline)
        .foregroundColor(Color(.secondaryLabel))
      }

      HStack(alignment: .firstTextBaseline, spacing: 5) {
        Image(systemName: "waveform.path")
          .foregroundColor(Color(.secondaryLabel))
        
        Text("\(viewModel.model.alias.emailsForwarded)")
          .fontWeight(.semibold)
        
        Text(Strings.AliasListItem.forwardsInline)
          .font(.caption)
          .foregroundColor(Color(.secondaryLabel))
        
        Text("\(viewModel.model.alias.emailsBlocked)")
          .fontWeight(.semibold)
        
        Text(Strings.AliasListItem.blockedInline)
          .font(.caption)
          .foregroundColor(Color(.secondaryLabel))
        
        Text("\(viewModel.model.alias.emailsSent + viewModel.model.alias.emailsReplied)")
          .fontWeight(.semibold)
        
        Text(Strings.AliasListItem.sentInline)
          .font(.caption)
          .foregroundColor(Color(.secondaryLabel))
      }
      
      CommitableTextField(title: Strings.AliasListItem.descriptionPlaceholder, text: viewModel.model.description) {
        viewModel.model.updateDescription($0)
      }
        .font(.subheadline)
        

      
      HStack(spacing: 20.0) {
        AliasEnabledView(alias: viewModel.model)
        
        Spacer()
        
        // These will be enabled later
//        Button(action: {}) {
//          Image(systemName: "doc.on.doc")
//          Text(Strings.AliasListItem.copyButton)
//        }
//
//        Button(action: {}) {
//          Image(systemName: "paperplane")
//          Text(Strings.AliasListItem.sendEmailButton)
//        }
      }
    }
    .padding()
    
  }
  
  private var regularLayout: some View {
        
    HStack(alignment: .top, spacing: 24) {
      

      StackedListItemView(
        topText:Strings.AliasListItem.created,
        bottomText: Strings.AliasListItem.createTime(viewModel.ageDescription)
      )
      
      VStack(alignment: .leading, spacing: 0) {
        
        AliasEmailView(email: viewModel.model.alias.email)
          .lineLimit(1)
        
        CommitableTextField(title: Strings.AliasListItem.descriptionPlaceholder, text: viewModel.model.description) {
          viewModel.model.updateDescription($0)
        }
        .font(.subheadline)
        
      }
      .layoutPriority(0)
      
      StackedListItemView(
        topText: Strings.AliasListItem.forwarded,
        bottomText: "\(viewModel.model.alias.emailsForwarded)"
      )
      
      StackedListItemView(
        topText: Strings.AliasListItem.blocked,
        bottomText: "\(viewModel.model.alias.emailsBlocked)"
      )
      
      StackedListItemView(
        topText: Strings.AliasListItem.replySent,
        bottomText: "\(viewModel.model.alias.emailsReplied)/\(viewModel.model.alias.emailsSent)"
      )
      
      VStack {
        Text(Strings.AliasListItem.active)
          .font(.headline)
          .foregroundColor(Color(.secondaryLabel))
        
        AliasEnabledView(alias: viewModel.model)
      }
      
    }
    .padding()
    
  }
  
}

struct AliasListItem_Previews: PreviewProvider {
  
  private static let viewModel = FakeAliasListItemViewModel()
  
  static var previews: some View {
    Group {
      AliasListItemView(viewModel: viewModel)
        .previewLayout(.sizeThatFits)
        .frame(minWidth: 768)
        .environment(\.horizontalSizeClass, .regular)
      
      AliasListItemView(viewModel: viewModel)
        .previewLayout(.sizeThatFits)
        .frame(minWidth: 375)
        .environment(\.horizontalSizeClass, .compact)
    }
  }
}
