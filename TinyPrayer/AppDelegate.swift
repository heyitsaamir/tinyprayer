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
    var statusBarItem: NSStatusItem!;
    
    var controller = PrayerController();

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let statusBar = NSStatusBar.system;
        statusBarItem = statusBar.statusItem(
        withLength: NSStatusItem.squareLength)
        statusBarItem.button?.title = "🕋"
        let statusBarMenu = NSMenu(title: "Cap Status Bar Menu")
        statusBarItem.menu = statusBarMenu;
        statusBarMenu.addItem(PrayerTimesListMenuItem(title: "foo", action: #selector(AppDelegate.orderABurrito), keyEquivalent: ""));

        statusBarMenu.addItem(
            withTitle: "Cancel burrito order",
            action: #selector(AppDelegate.cancelBurritoOrder),
            keyEquivalent: "")
        
        controller.sync {
            print("Done!");
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @objc func orderABurrito() {
        print("Ordering a burrito!")
    }

    @objc func cancelBurritoOrder() {
        print("Canceling your order :(")
    }
}

