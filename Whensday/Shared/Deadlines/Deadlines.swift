//
//  Deadlines.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct Deadlines: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.importance, ascending: false), NSSortDescriptor(keyPath: \Task.deadline, ascending: true), NSSortDescriptor(keyPath: \Task.doDate, ascending: true), NSSortDescriptor(keyPath: \Task.title, ascending: true)]) private var tasks: FetchedResults<Task>
    
    var dates: [Date] {
        var output = [Date()]
        
        for i in 1...7 {
            
            let newDate = Calendar.current.date(byAdding: .day, value: i, to: Date())!
            output.append(newDate)
        } //Next week
        
        for task in tasks { //for all the tasks
            //if dates does not have that day
            var contains = false
            
            for date in output {
                if task.formattedDeadline == formatDate(date) {
                    contains = true
                    break
                }
            }
            
            //then add it
            if !contains {
                if let taskDate = task.deadline {
                    output.append(taskDate)
                }
            }
        }
        
        return output
    }
    
    var undated: Bool {
        return tasksContainsDate(date: Date(timeIntervalSince1970: 0))
    }
    
    @Binding var currentView: Int
    @AppStorage("showCompleted") var showCompleted: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                
                SectionTitle(icon: "calendar", title: "Deadlines", textColor: Color.init("DeadlinesTitle"), currentView: $currentView)
                
                Divider()
                
                Spacer()
                    .frame(height: 10)
                
                ForEach(dates, id: \.self) {date in
                    
                    if tasksContainsDate(date: date) {
                        DeadlineDayView(key: formatDate(date))
                        
                        
                    }
                }
                
                showUndatedDeadline()
//                    .padding(.top)
                
                ForEach(tasks) {task in
                    if task.deadline == Date(timeIntervalSince1970: 0) {
                        if showCompleted {
                            TaskView(task: task)
                        } else if task.completed == false {
                            TaskView(task: task)
                        }
                    }
                }
            }
            .background(colorScheme == .dark ? Color.clear : Color.init("DeadlinesBackground"))
            .edgesIgnoringSafeArea(.all)
            
            NewTaskView()
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func tasksContainsDate(date: Date) -> Bool {
        for task in tasks {
            if task.formattedDeadline == formatDate(date) && task.formattedDeadline != formatDate(Date(timeIntervalSince1970: 0)) {
                
                return true
                
                
            }
        }
        
        return false
    }
}

struct showUndatedDeadline: View {
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.importance, ascending: false), NSSortDescriptor(keyPath: \Task.deadline, ascending: true), NSSortDescriptor(keyPath: \Task.doDate, ascending: true), NSSortDescriptor(keyPath: \Task.title, ascending: true)]) private var tasks: FetchedResults<Task>
    @AppStorage("showCompleted") var showCompleted: Bool = false
    
    var body: some View {
        HStack {
            Group {
                if tasks.contains(where: {task in
                    return task.deadline == Date(timeIntervalSince1970: 0)
                }) {
                    
                    if showCompleted {
                        Text("Undated")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.init("DeadlinesTitle"))
                            .padding([.horizontal])
                        
                    } else {
                        if tasks.contains(where: {task in
                            return task.deadline == Date(timeIntervalSince1970: 0) && !task.completed
                        }) {
                            Text("Undated")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.init("DeadlinesTitle"))
                                .padding([.horizontal])
                            
                            
                        }
                    }
                }
                Spacer()
            }
        }
    }
}
//
//struct Deadlines_Previews: PreviewProvider {
//    static var previews: some View {
//        Deadlines()
//    }
//}
