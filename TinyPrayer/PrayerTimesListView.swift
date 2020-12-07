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
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.widthAnchor.constraint(equalToConstant: 170).isActive = true;
        
        gridView = NSGridView();
        addSubview(gridView);
        gridView.translatesAutoresizingMaskIntoConstraints = false;
        gridView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        gridView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        gridView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0).isActive = true
        gridView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0).isActive = true
        
        
        gridView.addRow(with: [createLabel(with: "Fajr"), createLabel(with: "8:30")]);
        gridView.addRow(with: [createSeparator(), createSeparator()]);
        gridView.addRow(with: [createLabel(with: "Fajr"), createLabel(with: "8:30")]);
        gridView.addRow(with: [createSeparator(), createSeparator()]);
        gridView.addRow(with: [createLabel(with: "Fajr"), createLabel(with: "8:30")]);
        gridView.addRow(with: [createSeparator(), createSeparator()]);
        gridView.addRow(with: [createLabel(with: "Fajr"), createLabel(with: "8:30")]);
        gridView.addRow(with: [createSeparator(), createSeparator()]);
        gridView.addRow(with: [createLabel(with: "Fajr"), createLabel(with: "8:30")]);
        gridView.addRow(with: [createSeparator(), createSeparator()]);
        gridView.addRow(with: [createLabel(with: "Fajr"), createLabel(with: "8:30")]);
    
        gridView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        gridView.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
