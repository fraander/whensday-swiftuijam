//
//  DeadlinePickerPopover.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct DeadlinePickerPopover: View {
    
    @Binding var deadline: Date
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            #if os(iOS)
            HStack {
                Spacer()
                Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            
            Spacer()
            
            #endif
            
            DatePicker("Deadline", selection: $deadline, in: Date()..., displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
            
            #if os(iOS)
            Spacer()
            #endif
            
            if deadline != Date(timeIntervalSince1970: 0) {
                Button("Clear") {
                    deadline = Date(timeIntervalSince1970: 0)
                    CoreDataHelper.saveContext()
                }
                .padding(.bottom, 5)
            }
        }    }
}
//
//struct DeadlinePickerPopover_Previews: PreviewProvider {
//    static var previews: some View {
//        DeadlinePickerPopover()
//    }
//}
