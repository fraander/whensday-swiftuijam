//
//  NewTaskView.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct NewTaskView: View {
    
    @State var deadline = Date(timeIntervalSince1970: 0)
    @State var doDate = Date(timeIntervalSince1970: 0)
    @State var title = ""
    @State var importance = false
    
    var body: some View {
        #if os(macOS)
        Group {
            HStack {
                
                AddTextField(title: $title, deadline: $deadline, doDate: $doDate, importance: $importance)
                //                .padding(.trailing, 5)
                
                
                DoDatePicker(doDate: $doDate)
                DeadlinePicker(deadline: $deadline)
                
                Button(action: {
                    importance.toggle()
                }, label: {
                    !importance ? Image(systemName: "star") : Image(systemName: "star.fill")
                })
                
            }
            .padding()
            .frame(maxHeight: 60)
        }
        #endif
    }
    
    
    
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView()
    }
}
