//
//  ImportanceButton.swift
//  Whensday
//
//  Created by Frank on 2/20/21.
//

import SwiftUI

struct ImportanceButton: View {
    
    @ObservedObject var task: Task
    
    var body: some View {
        Button(action: {
            CoreDataHelper.toggleImportance(task)
        }, label: {
            !task.importance ? Image(systemName: "star") : Image(systemName: "star.fill")
        })
    }
}
//
//struct ImportanceButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ImportanceButton()
//    }
//}
