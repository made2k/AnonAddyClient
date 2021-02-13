//
//  CommitableTextField.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/16/21.
//

import Combine
import SwiftUI

/**
 This TextField shows a discard and save button while editing
 to allow the user to cancel or commit their changes.
 
 - Note:
 The controls of this textfield will remain visible if the text in the field
 is dirty. This is in addition to if the textfield is activly editing.
 */
struct CommitableTextField: View {
  
  // Our view model helps to determine if our input is dirty or not.
  @ObservedObject private var viewModel: CommitableTextFieldViewModel
  
  private let title: String
  private let commitCallback: ((String?) -> Void)?
  
  init(title: String, text: String?, onCommit: ((String?) -> Void)? = nil) {
    self.title = title
    self.viewModel = CommitableTextFieldViewModel(initialValue: text)
    self.commitCallback = onCommit
  }
  
  var body: some View {
    
    HStack(spacing: 16) {
      
      TextField(
        title,
        text: $viewModel.enteredValue,
        onEditingChanged: editingChanged,
        onCommit: commit
      )
      
      if viewModel.showsControls {
        
        Image(systemName: "xmark")
          .foregroundColor(Color(.systemRed))
          .font(.headline)
          .onTapGesture(perform: onCancel)
        
        // FIXME: IS there a better "save" systm icon?
        Image(systemName: "sdcard")
          .foregroundColor(Color(.systemTeal))
          .font(.headline)
          .onTapGesture(perform: commit)
        
      }
      
    }
    
  }
  
  private func editingChanged(_ isEditing: Bool) {
    viewModel.editing = isEditing
  }
  
  private func onCancel() {
    viewModel.editing = false
    viewModel.resetToDefault()
    dismissKeyboard()
  }
  
  private func commit() {
    
    // Don't commit if there's no changes
    guard viewModel.isDirty else {
      dismissKeyboard()
      return
    }
    
    viewModel.editing = false
    viewModel.didCommit()
    dismissKeyboard()
    commitCallback?(viewModel.enteredValue)
  }
  
  private func dismissKeyboard() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil
    )
  }
  
}

struct CommitableTextField_Previews: PreviewProvider {
  static var previews: some View {
    
    CommitableTextField(title: "Add description", text: "")
      .padding()
      .previewLayout(.sizeThatFits)
      .frame(minWidth: 400)
    
  }
}
