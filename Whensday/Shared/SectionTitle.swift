//
//  SectionTitle.swift
//  Whensday
//
//  Created by Frank on 2/21/21.
//

import SwiftUI

struct SectionTitle: View {
    
    let icon: String
    let title: String
    let textColor: Color
    @Binding var currentView: Int
    @AppStorage("showAddView") var showAddView: Bool = false
    @AppStorage("showCompleted") var showCompleted: Bool = false
    
    var body: some View {
        HStack {
            Group {
                Image(systemName: icon)
                    .font(.title)
                
                Text(title)
                    .font(.largeTitle)
                    .bold()
            }
            .foregroundColor(textColor)
            Spacer()
            
            #if os(macOS)
                PickerView(currentView: $currentView, tintColor: Color.init("TasksTitle"))
            
            #elseif os(iOS)
            Button(action: {
                showAddView.toggle()
            }, label: {
                Image(systemName: "plus")
            })
            .font(.title2)
            .foregroundColor(textColor)
            .padding(.trailing)
            #endif
        }
        .padding([.top, .leading])
        .padding(.top)
        .padding(.top)
        .onTapGesture {
            withAnimation {
                showCompleted.toggle()
            }
        }
    }
}
//
//struct SectionTitle_Previews: PreviewProvider {
//    @State var currentView = 0
//    static var previews: some View {
//
//        SectionTitle(icon: "checkmark.square", title: "Tasks", textColor: Color.init("TasksTitle"), currentView: $currentView)
//    }
//}
