//
//  AllTasks.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import Foundation
import SwiftUI
import CoreData

struct AllTasks: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedTask: Task?
    @State private var selectedTasks: Set<Task> = []
        
    @AppStorage("showCompleted") var showCompleted: Bool = false
    private var hasCompleted: Bool {
        
        for task in tasks {
            if task.completed == true {
                return true
            }
        }
        
        return false
    }
    
    @Binding var currentView: Int
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.importance, ascending: false), NSSortDescriptor(keyPath: \Task.deadline, ascending: true)]) private var tasks: FetchedResults<Task>
    var body: some View {
        
        VStack {
            ScrollView(.vertical) {
                
                SectionTitle(icon: "checkmark.square", title: "Tasks", textColor: Color.init("TasksTitle"), currentView: $currentView)
                
                Divider()
                
                Spacer()
                    .frame(height: 10)
                
                
                
                ForEach (tasks) { task in
                    if task.completed == false {
                        TaskView(task: task)
                    }
                }
                
                if tasks.contains(where: { (task) -> Bool in
                    !task.completed
                }) {
                Spacer()
                    .frame(height: 10)
                }
                
                if showCompleted && hasCompleted {
                    HStack {
                        Text("Completed")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.init("TasksTitle"))
                            .padding([.leading])
                        
                        Spacer()
                    }
                    
                    ForEach (tasks) { task in
                        if task.completed == true {
                            TaskView(task: task)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 10)
            }
            .background(colorScheme == .dark ? Color.clear : Color.init("AllTasksBackground"))
            .edgesIgnoringSafeArea(.all)
            
            
            NewTaskView()
            
        }
    }
}
//
//struct AllTasks_Previews: PreviewProvider {
//    static var previews: some View {
//        AllTasks()
//    }
//}
