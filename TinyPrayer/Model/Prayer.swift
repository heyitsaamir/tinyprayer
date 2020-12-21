//
//  Prayer.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/19/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import Foundation
import Networking

struct PrayerResponse: Decodable {
    struct PrayerResponseData: Decodable {
        struct DateResponse: Decodable {
            struct DateInfo: Decodable {
                let date: Date
                let format: String
                
                private enum CodingKeys: String, CodingKey {
                    case date
                    case format
                }
                
                init(from decoder: Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    
                    format = try container.decode(String.self, forKey: .format).replacingOccurrences(of: "D", with: "d").replacingOccurrences(of: "Y", with: "y")
                    let dateString = try container.decode(String.self, forKey: .date)
                    let formatter = DateFormatter()
                    formatter.dateFormat = format
                    formatter.calendar = Calendar(identifier: .iso8601)
                    if let date = formatter.date(from: dateString) {
                        self.date = date
                    } else {
                        throw DecodingError.dataCorruptedError(forKey: .date,
                              in: container,
                              debugDescription: "Date string does not match format expected by formatter.")
                    }
              }
            }
            
            let readable: String
            let gregorian: DateInfo
        }

        struct Metadata: Decodable {
            let latitude: Float
            let longitude: Float
            let timezone: String
        }
        
        struct TimingsForDay: Decodable {
            let fajr: Date
            let sunrise: Date
            let dhuhr: Date
            let asr: Date
            let sunset: Date
            let maghrib: Date
            let isha: Date
            let imsak: Date
            let midnight: Date
            
            private enum CodingKeys: String, CodingKey {
                case fajr = "Fajr"
                case sunrise = "Sunrise"
                case dhuhr = "Dhuhr"
                case asr = "Asr"
                case sunset = "Sunset"
                case maghrib = "Maghrib"
                case isha = "Isha"
                case imsak = "Imsak"
                case midnight = "Midnight"
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                func decodeData(for codingKey: CodingKeys) throws -> Date {
                    let dateString = try container.decode(String.self, forKey: codingKey)
                    let formatter = DateFormatter.hhmmWithTz
                    if let date = formatter.date(from: dateString) {
                        return date
                    } else {
                        throw DecodingError.dataCorruptedError(forKey: codingKey,
                              in: container,
                              debugDescription: "Date string does not match format expected by formatter.")
                    }
                }
                
                fajr = try decodeData(for: .fajr)
                sunrise = try decodeData(for: .sunrise)
                dhuhr = try decodeData(for: .dhuhr)
                asr = try decodeData(for: .asr)
                maghrib = try decodeData(for: .maghrib)
                sunset = try decodeData(for: .sunset)
                isha = try decodeData(for: .isha)
                midnight = try decodeData(for: .midnight)
                imsak = try decodeData(for: .imsak)
          }
        }
        
        let timings: TimingsForDay
        let date: DateResponse
        let meta: Metadata
    }
    
    let code: Int
    let status: String
    let data: [PrayerResponseData]
}
