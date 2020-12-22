//
//  PrayerNetworkingController.swift
//  TinyPrayer
//
//  Created by Aamir Jawaid on 12/19/20.
//  Copyright © 2020 Aamir Jawaid. All rights reserved.
//

import Foundation
import Networking

class PrayerController {
    private let networking = Networking(baseURL: "http://api.aladhan.com");
    
    func sync(onCompletion: @escaping (_ prayerTimes: PrayerTimes?) -> Void) -> Void {
        self.makeRequest { (response, error) in
            guard let response = response else {
                guard let error = error else {
                    print("Unknown error");
                    onCompletion(nil);
                    return;
                }
                print(error.localizedDescription);
                onCompletion(nil);
                return;
            }
            
            if let todaysPrayerTimes = response.data.first(where: { (data) -> Bool in
                return Calendar.current.isDateInToday(data.date.gregorian.date)
            }) {
                onCompletion(todaysPrayerTimes.timings);
            } else {
                onCompletion(nil)
            }
        }
    }
    
    private func makeRequest(onCompletion: @escaping (_ result: PrayerResponse?, _ error: Error?) -> Void) -> Void {
        networking.get("/v1/calendarByCity", parameters: ["city": "Issaquah", "country": "USA"]) { result in
            switch result {
            case .success(let response):
                do {
                    let prayerResponse = try JSONDecoder().decode(PrayerResponse.self, from: response.data)
                    onCompletion(prayerResponse, nil)
                } catch(let error) {
                    onCompletion(nil, error)
                }
                // Do something with JSON, you can also get arrayBody
            case .failure(let response):
                onCompletion(nil, response.error)
            }
        }
    }
}
