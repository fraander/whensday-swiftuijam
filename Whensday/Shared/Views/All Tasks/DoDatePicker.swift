//
//  DoDatePicker.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct DoDatePicker: View {
    
    @Binding var doDate: Date
    @State var showDoPicker = false
    
    var body: some View {
        Button {
            showDoPicker.toggle()
        } label: {
            HStack {
                Image(systemName: "alarm")
                
                if let doDateFormatted = formatDate(doDate) {
                    Text(doDateFormatted)
                }
            }
        }
        .popover(isPresented: $showDoPicker, content: {
            DoDatePickerPopover(doDate: $doDate)
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

//struct DoDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        DoDatePicker()
//    }
//}
