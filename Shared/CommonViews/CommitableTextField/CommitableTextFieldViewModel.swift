//
//  CommitableTextFieldViewModel.swift
//  AnonAddyClient
//
//  Created by Zach McGaughey on 2/18/21.
//

import Combine
import Foundation

final class CommitableTextFieldViewModel: ObservableObject {
  
  @Published private var storedValue: String
  @Published var enteredValue: String = ""
  @Published var editing: Bool = false
  @Published private(set) var isDirty: Bool = false
  
  @Published var showsControls: Bool = false
  
  init(initialValue: String?) {
    self.storedValue = initialValue ?? ""
    self.enteredValue = initialValue ?? ""
    
    Publishers.CombineLatest($enteredValue, $storedValue)
      .map(!=)
      .subscribe(on: DispatchQueue.main)
      .assign(to: &$isDirty)
    
    Publishers.CombineLatest($editing, $isDirty)
      .map { $0 || $1 }
      .subscribe(on: DispatchQueue.main)
      .assign(to: &$showsControls)
        
  }
  
  /// Restore the entered text to the stored value
  func resetToDefault() {
    enteredValue = storedValue
  }
  
  /**
   By commiting on the view model, we replace what text is used
   to consider ourselves dirty.
   
   An example, if this class is created with the text "Foo" and the text is changed
   on the text field to "Bar" it is dirty since the text has changed. If `didCommit`
   is called, it will no longer be diry since the entered text is now compared
   against "Bar".
   */
  func didCommit() {
    storedValue = enteredValue
  }
  
}
