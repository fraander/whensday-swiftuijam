//
//  AddViewPhone.swift
//  Whensday
//
//  Created by Frank on 2/21/21.
//

import SwiftUI

struct AddViewPhone: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var deadline: Date = Date(timeIntervalSince1970: 0)
    @State var doDate: Date = Date(timeIntervalSince1970: 0)
    @State var importance: Bool = false
    
    @State var currentView: Int
    
    var viewAccentColor: Color {
        switch currentView {
        case 0:
            return Color("AllTasksBackground")
        case 1:
            return Color("DueDatesBackground")
        case 2:
            return Color("DeadlinesBackground")
        default:
            return Color.accentColor
        }
    }
    
    var body: some View {
        #if os(iOS)
        VStack {
            HStack {
                
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                Button("Add Task") {
                    addTask()
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
            .foregroundColor(viewAccentColor)
            .padding([.top, .horizontal])
            
            Form {
                Section {
                    TextField("Task title", text: $title)
//                        .font(.largeTitle)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical)
                }
                
                Section {
                    Toggle("Importance", isOn: $importance)
                    
                    
                    DatePicker("Planned", selection: $doDate, in: Date()..., displayedComponents: .date)
                    
                    
                    DatePicker("Deadline", selection: $deadline, in: Date()..., displayedComponents: .date)
                    
                }
                .accentColor(viewAccentColor)
            }
            .listStyle(GroupedListStyle())
            //            .background()
            
        }
        .background(Color(UIColor.systemGroupedBackground))
        #endif
    }
    
    func addTask() {
        CoreDataHelper.add(title: title, deadline: deadline, doDate: doDate, importance: importance)
        title = ""
        importance = false
        deadline = Date(timeIntervalSince1970: 0)
        doDate = Date(timeIntervalSince1970: 0)
    }
}

//struct AddViewPhone_Previews: PreviewProvider {
//    static var previews: some View {
//        AddViewPhone()
//    }
//}
