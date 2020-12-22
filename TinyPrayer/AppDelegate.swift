//
//  AppDelegate.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/6/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    let popover = NSPopover()
    var statusBarItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength);
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        statusBarItem.button?.title = "🕋"
        statusBarItem.button?.action = #selector(AppDelegate.togglePopover(_:))
        self.popover.animates = false
        self.popover.behavior = .transient
        popover.contentViewController = PrayerTimesViewController(statusItem: statusBarItem)
    }
    
    @objc func togglePopover(_ sender: NSStatusItem) {
        if self.popover.isShown {
            closePopover(sender: sender)
        }
        else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = self.statusBarItem.button {
            NSApplication.shared.activate(ignoringOtherApps: true)
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    func closePopover(sender: Any?)  {
        self.popover.performClose(sender)
    }
}

