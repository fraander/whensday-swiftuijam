//
//  CoreDataHelper.swift
//  Core Data Template
//
//  Created by Frank on 2/18/21.
//

import CoreData
import Foundation
import SwiftUI

class CoreDataHelper {
    static private var viewContext = PersistenceController.shared.context
        
    static func add(title: String, deadline: Date, doDate: Date, importance: Bool) {
        withAnimation {
            guard title != "" else {return}
            
            let newTask = Task(context: viewContext) //create new one
            
            newTask.id = UUID()
            newTask.creationDate = Date()
            
            newTask.title = title
            newTask.completed = false
            newTask.importance = importance
            
            newTask.deadline = deadline
            newTask.doDate = doDate
            
            
            saveContext() //save context
        }
    }
    
    static func delete(_ task: Task) {
        withAnimation {
            viewContext.delete(task)
            saveContext()
        }
    }
    
    static func deleteEntities(offsets: IndexSet, tasks: FetchedResults<Task>) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    static func update(_ task: FetchedResults<Task>.Element, newTitle: String) {
        withAnimation {
            task.title = newTitle
            saveContext()
        }
    }
    
    static func changeDetails(_ task: FetchedResults<Task>.Element, newTitle: String, newDoDate: Date, newDeadline: Date, newImportance: Bool) {
        task.title = newTitle
        task.doDate = newDoDate
        task.deadline = newDeadline
        task.importance = newImportance
        
        saveContext()
    }
    
    static func doToday(_ task: FetchedResults<Task>.Element) {
        task.doDate = Date()
        saveContext()
    }
    
    static func dueToday(_ task: FetchedResults<Task>.Element) {
        task.deadline = Date()
        saveContext()
    }
    
    static func clearDo(_ task: FetchedResults<Task>.Element) {
        task.doDate = Date(timeIntervalSince1970: 0)
        saveContext()
        
    }
    
    
    static func clearDeadline(_ task: FetchedResults<Task>.Element) {
        task.deadline = Date(timeIntervalSince1970: 0)
        saveContext()
        
    }
    
    static func toggleImportance(_ task: FetchedResults<Task>.Element) {
        withAnimation {
            task.importance.toggle()
            saveContext()
        }
        
    }
    
    static func updateTask(task: Task, title: String) {
        task.title = "\(title)"
        saveContext()
    }
    
    static func toggleTaskCompletion(_ task: FetchedResults<Task>.Element) {
        withAnimation {
            task.completed.toggle()
            saveContext()
        }
    }
    
    static func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
}
