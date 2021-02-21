//
//  Task.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct TaskView: View {
    
    @ObservedObject var task: Task
    
    var taskComplete: Bool {
        task.completed
    }
    @State var showEdit = false
    @State var showDetail = false
    @State var newTitle: String = ""
    
    @State var showRenameView = false
    @State var renameContent = ""
    
    var body: some View {
        
        #if os(macOS)
        VStack {
            HStack {
                Button {
                    CoreDataHelper.toggleTaskCompletion(task)
                } label: {
                    if !task.completed {
                        Image(systemName: "checkmark.circle")
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                
                Text("\(task.title ?? "")")
                    .strikethrough(taskComplete ? true : false)
                    .onTapGesture {
                        showEdit.toggle()
                    }
                    .foregroundColor(taskComplete ? .secondary : .primary)
                
                Spacer()
                
                //date updaters
                HStack {
                    
                    DoDateEditor(task: task)
                    DeadlineEditor(task: task)
                    ImportanceButton(task: task)
                }
                
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.init("TaskBackground")))
        .padding(.horizontal)
        .contextMenu {
            Button(action: {
                showRenameView.toggle()
                //                CoreDataHelper.update(task, newTitle: )
            }, label: {
                HStack {
                    Image(systemName: "pencil.and.outline")
                    Text("Rename")
                }
            })
            
            Divider()
            
            if task.formattedDoDate != formatDate(Date()) {
                Button(action: {
                    CoreDataHelper.doToday(task)
                }, label: {
                    HStack {
                        Image(systemName: "sun.max")
                        Text("Do Today")
                    }
                })
            } else {
                
                Button(action: {
                    CoreDataHelper.clearDo(task)
                }, label: {
                    HStack {
                        Image(systemName: "xmark.circle")
                        Text("Clear Planned")
                    }
                })
            }
            
            if task.formattedDeadline != formatDate(Date()) {
                Button(action: {
                    CoreDataHelper.dueToday(task)
                }, label: {
                    HStack {
                        Image(systemName: "calendar.badge.exclamationmark")
                        Text("Due Today")
                    }
                })
            } else {
                
                Button(action: {
                    CoreDataHelper.clearDeadline(task)
                }, label: {
                    HStack {
                        Image(systemName: "calendar.badge.minus")
                        Text("Clear Deadline")
                    }
                })
            }
            
            Button(action: {
                CoreDataHelper.toggleImportance(task)
            }, label: {
                HStack {
                    Image(systemName: "\(!task.importance ? "star" : "star.slash.fill")")
                    Text("\(!task.importance ? "Make Important" : "Remove Importance")")
                }
            })
            
            Divider()
            
            Button(action: {
                CoreDataHelper.delete(task)
            }, label: {
                HStack {
                    Image(systemName: "trash")
                    Text("Delete")
                }
            })
        }
        .sheet(isPresented: $showRenameView) {
            renameModal(renameContent: $renameContent, task: task)
        }
        
        #elseif os(iOS)
        
        VStack {
            HStack {
                Button {
                    CoreDataHelper.toggleTaskCompletion(task)
                } label: {
                    if !task.completed {
                        Image(systemName: "checkmark.circle")
                    } else {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                
                Text("\(task.title ?? "")")
                    .strikethrough(taskComplete ? true : false)
                    .onTapGesture {
                        showEdit.toggle()
                    }
                    .foregroundColor(taskComplete ? .secondary : .primary)
                
                Spacer()
                
                //date updaters
                HStack {
                    HStack {
                        
                        if let doDateFormatted = formatDateThrowing(task.doDate) {
                            HStack {
                                //                                Spacer()
                                Image(systemName: "alarm")
                                    .foregroundColor(doDateFormatted == "Today" ? Color.primary : Color.secondary)
                                Text(doDateFormatted != "Today" ? String(doDateFormatted.dropLast(3)) : "")
                            }
                            //                            .padding(.top, 5)
                        }
                        
                        if let deadlineFormatted = formatDateThrowing(task.deadline) {
                            HStack {
                                //                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundColor(deadlineFormatted == "Today" ? Color.primary : Color.secondary)
                                Text(deadlineFormatted != "Today" ? String(deadlineFormatted.dropLast(3)) : "")
                            }
                            //                            .padding(.top, 5)
                        }
                    }
                    .foregroundColor(Color.secondary)
                    
                    ImportanceButton(task: task)
                    //                        .padding(.horizontal, 5)
                }
                
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.init("TaskBackground")))
        .padding(.horizontal)
        .contextMenu {
            Button(action: {
                showRenameView.toggle()
                //                CoreDataHelper.update(task, newTitle: )
            }, label: {
                HStack {
                    Image(systemName: "pencil.and.outline")
                    Text("Edit Details")
                }
            })
            
            Divider()
            
            if task.formattedDoDate != formatDate(Date()) {
                Button(action: {
                    CoreDataHelper.doToday(task)
                }, label: {
                    HStack {
                        Image(systemName: "sun.max")
                        Text("Do Today")
                    }
                })
            }
            
            if task.formattedDeadline != formatDate(Date()) {
                Button(action: {
                    CoreDataHelper.dueToday(task)
                }, label: {
                    HStack {
                        Image(systemName: "calendar.badge.exclamationmark")
                        Text("Due Today")
                    }
                })
            }
            
            if task.formattedDeadline != formatDate(Date()) || task.formattedDoDate != formatDate(Date()) {
                Divider()
            }
            
            if task.formattedDoDate != formatDate(Date(timeIntervalSince1970: 0)) {
            Button(action: {
                CoreDataHelper.clearDo(task)
            }, label: {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text("Clear Planned")
                }
            })
            }
            
            
            if task.formattedDeadline != formatDate(Date(timeIntervalSince1970: 0)) {
            
            Button(action: {
                CoreDataHelper.clearDeadline(task)
            }, label: {
                HStack {
                    Image(systemName: "calendar.badge.minus")
                    Text("Clear Deadline")
                }
            })
            }
            
            
//            Button(action: {
//                CoreDataHelper.toggleImportance(task)
//            }, label: {
//                HStack {
//                    Image(systemName: "\(!task.importance ? "star" : "star.slash.fill")")
//                    Text("\(!task.importance ? "Make Important" : "Remove Importance")")
//                }
//            })
//            
            Divider()
            
            Button(action: {
                CoreDataHelper.delete(task)
            }, label: {
                HStack {
                    Image(systemName: "trash")
                    Text("Delete")
                }
            })
        }
        .sheet(isPresented: $showRenameView) {
            renameModal(renameContent: $renameContent, task: task)
        }
        
        #endif
    }
    
    func formatDateThrowing (_ date: Date?) -> String? {
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
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

struct renameModal: View {
    
    @Binding var renameContent: String
    @ObservedObject var task: Task
    @Environment(\.presentationMode) var presentationMode
    
    @State var importance: Bool = false
    @State var doDate: Date = Date(timeIntervalSince1970: 0)
    @State var deadline: Date = Date(timeIntervalSince1970: 0)
    
    //    @State var currentView: Int
    //
    //    var viewAccentColor: Color {
    //        switch currentView {
    //        case 0:
    //            return Color("AllTasksBackground")
    //        case 1:
    //            return Color("DueDatesBackground")
    //        case 2:
    //            return Color("DeadlinesBackground")
    //        default:
    //            return Color.accentColor
    //        }
    //    }
    
    var body: some View {
        Group {
            #if os(iOS)
            VStack {
                HStack {
                    
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                    
                    Button("Rename") {
                        updateTaskDetails()
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
                //                .foregroundColor(viewAccentColor)
                .padding([.top, .horizontal])
                
                Form {
                    Section {
                        TextField("New title", text: $renameContent, onCommit: {
                            updateTaskDetails()
                        })
                        .onAppear(perform: {
                            renameContent = task.title ?? ""
                        })
                        //                        .font(.largeTitle)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical)
                    }
                    
                    Section {
                        Toggle("Importance", isOn: $importance)
                        
                        
                        DatePicker("Planned", selection: $doDate, in: Date()..., displayedComponents: .date)
                        
                        
                        DatePicker("Deadline", selection: $deadline, in: Date()..., displayedComponents: .date)
                        
                    }
                    .onAppear {
                        importance = task.importance
                        doDate = task.doDate ?? Date(timeIntervalSince1970: 0)
                        deadline = task.deadline ?? Date(timeIntervalSince1970: 0)
                    }
                    //                    .accentColor(viewAccentColor)
                }
                .listStyle(GroupedListStyle())
                //            .background()
                
            }
            .background(Color(UIColor.systemGroupedBackground))
            
            #elseif os(macOS)
            VStack {
                TextField("New title", text: $renameContent, onCommit: {
                    commit()
                })
                .onAppear(perform: {
                    renameContent = task.title ?? ""
                })
                .frame(minWidth: 100)
                
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .keyboardShortcut(.cancelAction)
                    
                    Button("Rename") {
                        commit()
                    }
                    .keyboardShortcut(.defaultAction)
                }
            }
            #endif
        }
        .padding()
    }
    
    func commit() {
        CoreDataHelper.update(task, newTitle: renameContent)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func updateTaskDetails() {
        CoreDataHelper.changeDetails(task, newTitle: renameContent, newDoDate: doDate, newDeadline: deadline, newImportance: importance)
        self.presentationMode.wrappedValue.dismiss()
        
    }
}
//
//struct Task_Previews: PreviewProvider {
//    static var previews: some View {
//        Task()
//    }
//}
