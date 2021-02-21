//
//  AddTextField.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct AddTextField: View {
    
    @Binding var title: String
    @Binding var deadline: Date
    @Binding var doDate: Date
    @Binding var importance: Bool

    
    var body: some View {
        Button {
            addTask()
        } label: {
            Image(systemName: "plus")
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 5)
        
        TextField("Add task", text: $title, onCommit: {
            addTask()
        })
        .textFieldStyle(PlainTextFieldStyle())
    }
    
    
    func addTask() {
        CoreDataHelper.add(title: title, deadline: deadline, doDate: doDate, importance: importance)
        title = ""
        importance = false
        deadline = Date(timeIntervalSince1970: 0)
        doDate = Date(timeIntervalSince1970: 0)
    }
}

//struct AddTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTextField()
//    }
//}
