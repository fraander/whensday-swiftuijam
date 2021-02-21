//
//  NetView.swift
//  When's it Do
//
//  Created by Frank on 2/19/21.
//

import SwiftUI

struct NetView: View {
    
    @Binding var currentView: Int
    let viewOptions: [String] //#TODO move the picker to the titlebar of each of the views (or move the title bar to here) && make the picker not segemented but macos standard or a much smaller segmented picker. Then add keyboard shortcuts for moving it.
    
    var body: some View {
//        Group {
            if currentView == 0 { //All tasks
                AllTasks(currentView: $currentView)
            } else if currentView == 1 { //Do Dates
                DoDates(currentView: $currentView)
            } else { //Deadlines
                Deadlines(currentView: $currentView)
            }
//        }
    }
}
