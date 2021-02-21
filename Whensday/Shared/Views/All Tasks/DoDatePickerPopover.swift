//
//  DoDatePickerPopover.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct DoDatePickerPopover: View {
    
    @Binding var doDate: Date
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
            
            DatePicker("Do Date", selection: $doDate, in: Date()..., displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
            
            #if os(iOS)
            Spacer()
            #endif
            
            if doDate != Date(timeIntervalSince1970: 0) {
                Button("Clear") {
                    doDate = Date(timeIntervalSince1970: 0)
                    CoreDataHelper.saveContext()
                }
                .padding(.bottom, 5)
            }
        }
    }
}
//
//struct DoDatePickerPopover_Previews: PreviewProvider {
//    static var previews: some View {
//        DoDatePickerPopover()
//    }
//}
