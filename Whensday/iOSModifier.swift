//
//  iOSModifier.swift
//  Whensday (iOS)
//
//  Created by Frank on 2/21/21.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        modifier(self)
        #else
        self
        #endif
    }
    
    @ViewBuilder
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        modifier(self)
        #else
        self
        #endif
    }
}
