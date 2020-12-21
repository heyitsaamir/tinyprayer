//
//  Date.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/20/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let hhmmWithTz: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm (zzz)"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
}
