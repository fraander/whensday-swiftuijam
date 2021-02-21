//
//  DeadlineEditor.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct DeadlineEditor: View {
    
    @ObservedObject var task: Task
    @State var showDeadlinePicker = false

    
    var body: some View {
        if let _ = task.deadline {
            Button {
                showDeadlinePicker.toggle()
                
            } label: {
                HStack {
                    Image(systemName: "calendar")
                    
                    if let deadlineFormatted = formatDate(task.deadline) {
                        Text(deadlineFormatted)
                    }
                }
            }
            .popover(isPresented: $showDeadlinePicker, content: {
                TaskDeadlineEditorPopover(task: task)
            })
        }
    }
    
    func formatDate(_ date: Date?) -> String? {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            
            let formattedDate = dateFormatter.string(from: date)
            let today = dateFormatter.string(from: Date())
            let og = dateFormatter.string(from: Date(timeIntervalSince1970: 0))
            
            if formattedDate == og {
                return nil
            } else if formattedDate == today {
                return "Today"
            } else {
                return dateFormatter.string(from: date)
            }
            
        } else {return nil}
    }
}

//struct DeadlineEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        DeadlineEditor()
//    }
//}
