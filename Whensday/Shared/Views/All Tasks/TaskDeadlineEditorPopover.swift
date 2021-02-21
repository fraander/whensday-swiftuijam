//
//  TaskDeadlineEditorPopover.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct TaskDeadlineEditorPopover: View {
    
    @ObservedObject var task: Task
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
            
            DatePicker(
                "Deadline",
                selection: Binding(get: {
                    task.deadline ?? Date()
                }, set: { newDate in
                    task.deadline = newDate
                    CoreDataHelper.saveContext()
                }),
                in: Date()...,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .labelsHidden()
            
            #if os(iOS)
            Spacer()
            #endif
            
            if task.deadline != Date(timeIntervalSince1970: 0) {
                Button("Clear") {
                    task.deadline = Date(timeIntervalSince1970: 0)
                    CoreDataHelper.saveContext()
                }
                .padding(.bottom, 5)
            }
        }
    }
}

//struct TaskDeadlineEditorPopover_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskDeadlineEditorPopover()
//    }
//}
