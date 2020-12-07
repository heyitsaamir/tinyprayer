//
//  Label.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/6/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import SwiftUI

func createLabel(with text: String) -> NSTextField {
    let label = NSTextField()
    label.stringValue = text
    label.textColor = .white
    label.backgroundColor = .clear
    label.isBezeled = false
    label.isEditable = false
    
    return label;
}
