//
//  PickerView.swift
//  When's it Do
//
//  Created by Frank on 2/20/21.
//

import SwiftUI

struct PickerView: View {
    
    @Binding var currentView: Int
    let views = ["Tasks", "Planned", "Deadlines"]
    let tintColor: Color
    @AppStorage("showCompleted") var showCompleted: Bool = false
    
    var body: some View {
        
        #if os(macOS)
        Button {
//            withAnimation {
                showCompleted.toggle()
//            }
        } label: {
            showCompleted ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "checkmark.circle")
        }

        
        Picker(selection: $currentView, label: Text("Current view")) {
            ForEach(0..<views.count) { option in
                Text(views[option])
                
            }
        }
        .accentColor(tintColor)
        .labelsHidden()
        .frame(width: 100)
        .padding(.trailing)
        //                .pickerStyle(SegmentedPickerStyle())
        
        #endif
    }
}
