//
//  PrayerTimesListView.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/6/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import SwiftUI

class PrayerTimesListView: NSView, NibLoadable {
    var gridView: NSGridView!;
    let dateFormatter = DateFormatter();
    var prayerTypeToTextFieldDictionary: Dictionary<InterestingPrayerType, PrayerTime> = [:]
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        gridView = NSGridView();
        addSubview(gridView);
        
        gridView.translatesAutoresizingMaskIntoConstraints = false;
        gridView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0).isActive = true
        gridView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
        gridView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        gridView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0).isActive = true
    
        gridView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        gridView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        dateFormatter.dateFormat = "hh:mm a"
        prayerTypeToTextFieldDictionary[InterestingPrayerType.imsak] = PrayerTime(prayerTime: InterestingPrayerType.imsak)
        prayerTypeToTextFieldDictionary[InterestingPrayerType.fajr] = PrayerTime(prayerTime: InterestingPrayerType.fajr)
        prayerTypeToTextFieldDictionary[InterestingPrayerType.sunrise] = PrayerTime(prayerTime: InterestingPrayerType.sunrise)
        prayerTypeToTextFieldDictionary[InterestingPrayerType.dhuhr] = PrayerTime(prayerTime: InterestingPrayerType.dhuhr)
        prayerTypeToTextFieldDictionary[InterestingPrayerType.asr] = PrayerTime(prayerTime: InterestingPrayerType.asr)
        prayerTypeToTextFieldDictionary[InterestingPrayerType.maghrib] = PrayerTime(prayerTime: InterestingPrayerType.maghrib)
        prayerTypeToTextFieldDictionary[InterestingPrayerType.sunset] = PrayerTime(prayerTime: InterestingPrayerType.sunset)
        prayerTypeToTextFieldDictionary[InterestingPrayerType.isha] = PrayerTime(prayerTime: InterestingPrayerType.isha)
        
        gridView.addRow(with: [ prayerTypeToTextFieldDictionary[InterestingPrayerType.imsak]!]);
        gridView.addRow(with: [createSeparator()]);
        gridView.addRow(with: [ prayerTypeToTextFieldDictionary[InterestingPrayerType.fajr]!]);
        gridView.addRow(with: [createSeparator()]);
        gridView.addRow(with: [ prayerTypeToTextFieldDictionary[InterestingPrayerType.sunrise]!]);
        gridView.addRow(with: [createSeparator()]);
        gridView.addRow(with: [ prayerTypeToTextFieldDictionary[InterestingPrayerType.dhuhr]!]);
        gridView.addRow(with: [createSeparator()]);
        gridView.addRow(with: [prayerTypeToTextFieldDictionary[InterestingPrayerType.asr]!]);
        gridView.addRow(with: [createSeparator()]);
        gridView.addRow(with: [prayerTypeToTextFieldDictionary[InterestingPrayerType.maghrib]!]);
        gridView.addRow(with: [createSeparator()]);
        gridView.addRow(with: [ prayerTypeToTextFieldDictionary[InterestingPrayerType.sunset]!]);
        gridView.addRow(with: [createSeparator()]);
        gridView.addRow(with: [prayerTypeToTextFieldDictionary[InterestingPrayerType.isha]!]);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    func setTimes(for prayerTimes: PrayerTimes) {
        self.updateLabel(for: InterestingPrayerType.fajr, with: prayerTimes.fajr)
        self.updateLabel(for: InterestingPrayerType.sunrise, with: prayerTimes.sunrise)
        self.updateLabel(for: InterestingPrayerType.dhuhr, with: prayerTimes.dhuhr)
        self.updateLabel(for: InterestingPrayerType.asr, with: prayerTimes.asr)
        self.updateLabel(for: InterestingPrayerType.maghrib, with: prayerTimes.maghrib)
        self.updateLabel(for: InterestingPrayerType.sunset, with: prayerTimes.sunset)
        self.updateLabel(for: InterestingPrayerType.isha, with: prayerTimes.isha)
        self.updateLabel(for: InterestingPrayerType.imsak, with: prayerTimes.imsak)
    }
    
    private func updateLabel(for prayerType: InterestingPrayerType, with time: Date) {
            prayerTypeToTextFieldDictionary[prayerType]!.updateTime(time: dateFormatter.string(from: time))
    }
}

func createSeparator() -> NSView {
    let separator = Separator();
    separator.translatesAutoresizingMaskIntoConstraints = false;
    separator.heightAnchor.constraint(equalToConstant: 1).isActive = true;
    
    return separator;
}

class Separator: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // #1d161d
        NSColor(red: 1, green:1, blue: 1, alpha: 0.4).setFill()
        dirtyRect.fill()
    }
}

class PrayerTime: NSView {
    private var prayerTime: NSTextField!;
    
    init(prayerTime: InterestingPrayerType) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.widthAnchor.constraint(equalToConstant: 170).isActive = true;
        self.heightAnchor.constraint(equalToConstant: 15).isActive = true;
        
        let label = createLabel(with: prayerTime.stringValue);
        self.prayerTime = createLabel(with: "?");
        self.addSubview(label);
        self.addSubview(self.prayerTime);
        
        label.translatesAutoresizingMaskIntoConstraints = false
        self.prayerTime.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.prayerTime.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.prayerTime.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.prayerTime.leftAnchor).isActive = true
    }
    
    func updateTime(time: String) {
        self.prayerTime.stringValue = time;
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
}
