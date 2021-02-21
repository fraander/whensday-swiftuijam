//
//  DeadlinePicker.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct DeadlinePicker: View {
    
    @Binding var deadline: Date
    @State var showDeadlinePicker = false
    
    var body: some View {
        Button {
            showDeadlinePicker.toggle()
        } label: {
            HStack {
                
                Image(systemName: "calendar")
                
                if let deadlineFormatted = formatDate(deadline) {
                    Text(deadlineFormatted)
                }
            }
        }
        .popover(isPresented: $showDeadlinePicker, content: {
            DeadlinePickerPopover(deadline: $deadline)
        })
    }
    
    func formatDate(_ date: Date) -> String? {
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
    }
}
//
//struct DeadlinePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        DeadlinePicker()
//    }
//}
