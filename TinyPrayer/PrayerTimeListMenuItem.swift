//
//  Popover.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/6/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import SwiftUI


class PrayerTimesListMenuItem: NSMenuItem {
    var prayerTimesList: PrayerTimesListView!;
    
    override init(title string: String, action selector: Selector?, keyEquivalent charCode: String) {
        super.init(title: string, action: selector, keyEquivalent: charCode)
        self.setup();
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder);
        self.setup();
    }
    
    private func setup() {
        self.view = PrayerTimesListView.createFromNib();
    }
}
