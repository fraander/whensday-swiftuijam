//
//  DoDateEditor.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct DoDateEditor: View {
    
    @ObservedObject var task: Task
    @State var showDoDatePicker = false

    
    var body: some View {
        if let _ = task.doDate {
            Button {
                showDoDatePicker.toggle()
            } label: {
                HStack {
                    Image(systemName: "alarm")
                    
                    if let doDateFormatted = formatDate(task.doDate) {
                        Text(doDateFormatted)
                    }
                }
            }
            .popover(isPresented: $showDoDatePicker, content: {
                TaskDoDateEditorPopover(task: task)
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

//struct DoDateEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        DoDateEditor()
//    }
//}
