//
//  DayView.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct DayView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("showCompleted") var showCompleted: Bool = false
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.importance, ascending: false), NSSortDescriptor(keyPath: \Task.deadline, ascending: true), NSSortDescriptor(keyPath: \Task.doDate, ascending: true), NSSortDescriptor(keyPath: \Task.title, ascending: true)]) private var tasks: FetchedResults<Task>
    let key: String
    
    var computedDateTitle: String {
        if key == formatDate(Date()) {
            return "Today"
        }
        
        if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
            if key == formatDate(tomorrow) {
                return "Tomorrow"
            }
        }
        
        return key
    }
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading) {
                if tasks.contains(where: { task in
                    return task.formattedDoDate == key
                }){
                    if showCompleted {
                        doDateDayHeader(computedDateTitle: computedDateTitle)
                        
                    } else {
                        if tasks.contains(where: { task in
                            return task.formattedDoDate == key && !task.completed
                        }) {
                            doDateDayHeader(computedDateTitle: computedDateTitle)
                            
                        }
                    }
                }
                
                ForEach(tasks) { task in
                    if task.formattedDoDate == key {
                        if showCompleted {
                            TaskView(task: task)
                        } else if task.completed == false {
                            TaskView(task: task)
                        }
                    }
                }
            }
//            .padding(.vertical)
            //            .background(Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 25)))
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    struct doDateDayHeader: View {
        
        let computedDateTitle: String
        
        var body: some View {
            HStack {
                Text("\(computedDateTitle)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.init("DoDatesTitle"))
                    .padding(.horizontal)
                Spacer()
            }
        }
    }
}

//struct DayView_Previews: PreviewProvider {
//    static var previews: some View {
//        let date = "2/20/21"
//        DayView(key: date)
//    }
//
//    func formatDate(_ date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
//        dateFormatter.timeStyle = .none
//
//        let formattedDate = dateFormatter.string(from: date)
//        return formattedDate
//    }
//}
