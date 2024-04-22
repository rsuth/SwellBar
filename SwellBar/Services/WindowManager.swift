//
//  WindowManager.swift
//  SwellBar
//
//  Created by Rick Sutherland on 4/23/24.
//

import Foundation
import SwiftUI

class WindowManager {
    static let shared = WindowManager() // singleton
    private var settingsWindow: NSWindow?

    func openSettingsWindow(preferences: UserPreferences) {
        if settingsWindow == nil {
            let settingsView = SettingsView(preferences: preferences)
            let hostingView = NSHostingController(rootView: settingsView)

            let window = NSWindow(contentViewController: hostingView)
            window.setContentSize(NSSize(width: 360, height: 400))
            window.title = "Settings"

            settingsWindow = window
        }
        
        settingsWindow?.makeKeyAndOrderFront(nil)
        NSApplication.shared.activate(ignoringOtherApps: true)  // Ensure the app comes to the foreground
    }
}
