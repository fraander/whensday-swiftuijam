//
//  File.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

@main
struct Whens_it_due_App: App {
    
    let persistenceContainer = PersistenceController.shared
    @State var currentView = 0
    @State var showPreferences = false
    let views = ["Tasks", "Planned", "Deadlines"]
    @AppStorage("showCompleted") var showCompleted = false
    @AppStorage("showAddView") var showAddView: Bool = false
    
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
    
    var body: some Scene {
        
        #if os(macOS)
        WindowGroup {
            ZStack {
                VStack {
                    
                    NetView(currentView: $currentView, viewOptions: views)
                        .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
                    
                }
                .frame(minWidth: 300, minHeight: 400)
                
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .commands() {
            CommandGroup(before: .toolbar) {
                Button("Tasks") {
                    currentView = 0
                }
                .keyboardShortcut("1", modifiers: .command)
                
                Button("Planned") {
                    currentView = 1
                }
                .keyboardShortcut("2", modifiers: .command)
                
                Button("Deadlines") {
                    currentView = 2
                }
                .keyboardShortcut("3", modifiers: .command)
                
                Divider()
                
                Button("Show Completed") {
                    showCompleted.toggle()
                }
                .keyboardShortcut("x", modifiers: [.command, .shift])
            }
            
            //            CommandGroup(before: CommandGroupPlacement.textEditing) {
            //                Button("Clear Planned") {
            //                    for task in tasks {
            //                        CoreDataHelper.clearDo(task)
            //                    }
            //                }
            //                .keyboardShortcut("w", modifiers: [.command, .shift])
            //
            //                Button("Clear Deadlines") {
            //                    for task in tasks {
            //                        CoreDataHelper.clearDeadline(task)
            //                    }
            //                }
            //                .keyboardShortcut("e", modifiers: [.command, .shift])
            //            }
            //            CommandGroup(before: .appSettings) {
            //                Button("Preferences") {
            //                    showPreferences.toggle()
            //                }
            //                .keyboardShortcut(",", modifiers: .command)
            //            }
        } //keyboard commands macos
        
        #elseif os(iOS)
        WindowGroup {
            VStack {
                
                TabView(selection: $currentView) {
                    AllTasks(currentView: $currentView )
                        .tabItem({
                            Image(systemName: "checkmark.square")
                            Text("Tasks")
                        })
                        .tag(0)
                    
                    DoDates(currentView: $currentView)
                        .tabItem({
                            Image(systemName: "alarm.fill")
                            Text("Planned")
                        })
                        .tag(1)
                    
                    Deadlines(currentView: $currentView)
                        .tabItem({
                            Image(systemName: "calendar")
                            Text("Deadlines")
                        })
                        .tag(2)
                }
                .accentColor(viewAccentColor)
            }
            .sheet(isPresented: $showAddView) {
                AddViewPhone(currentView: currentView)
            }
            .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
        #endif
    }
}
