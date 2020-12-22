//
//  PrayerTimesViewController.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/22/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import Foundation
import SwiftUI

class PrayerTimesViewController: NSViewController {
    private lazy var contentView = PrayerTimesListView()
    let dateFormatter = DateFormatter();
    private weak var statusItem: NSStatusItem?
    let controller = PrayerController();
    let activity = NSBackgroundActivityScheduler(identifier: "com.example.TinyPrayer.updatePrayerTime")

   override func loadView() {
      view = contentView
   }

    init(statusItem: NSStatusItem) {
      super.init(nibName: nil, bundle: nil)
        dateFormatter.dateFormat = "hh:mm a"
        self.statusItem = statusItem
   }

   required init?(coder: NSCoder) {
      fatalError()
   }
    
    override func viewDidLoad() {
        controller.sync { (times) in
            if let times = times {
                self.scheduleTasks(times: times)
            }
        }
    }
    
    struct TimeWithPrayerType {
        let time: Date
        let type: InterestingPrayerType
    }
    
    func scheduleTasks(times: PrayerTimes) {
        self.contentView.setTimes(for: times)
        
        let timeInOrder = [
            TimeWithPrayerType(time: times.imsak, type: .imsak),
            TimeWithPrayerType(time: times.fajr, type: .fajr),
            TimeWithPrayerType(time: times.sunrise, type: .sunrise),
            TimeWithPrayerType(time: times.dhuhr, type: .dhuhr),
            TimeWithPrayerType(time: times.asr, type: .asr),
            TimeWithPrayerType(time: times.maghrib, type: .maghrib),
            TimeWithPrayerType(time: times.sunset, type: .sunset),
            TimeWithPrayerType(time: times.isha, type: .isha)
        ];
        
        let currentTime = Date();
        let dateComponents: Set<Calendar.Component> = Set<Calendar.Component>(arrayLiteral: .hour, .minute, .second);
        let upcommingTime = timeInOrder.first { (timeWithPrayerType) -> Bool in
            let components = NSCalendar.current.dateComponents(dateComponents, from: timeWithPrayerType.time)
            let date = NSCalendar.current.date(bySettingHour: components.hour!, minute: components.minute!, second: components.second!, of: currentTime)
            return date!.compare(currentTime) == .orderedDescending
        }
        
        if let upcommingTime = upcommingTime {
            statusItem?.button?.title =  upcommingTime.type.stringValue + " " + dateFormatter.string(from: upcommingTime.time)
        }
    }
}
