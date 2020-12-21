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
    
    func sync(onCompletion: @escaping () -> Void) -> Void {
        self.makeRequest { (response, error) in
            guard let response = response else {
                guard let error = error else {
                    print("Unknown error");
                    onCompletion();
                    return;
                }
                print(error.localizedDescription);
                onCompletion();
                return;
            }
            
            onCompletion();
        }
    }
    
    private func makeRequest(onCompletion: @escaping (_ result: PrayerResponse?, _ error: Error?) -> Void) -> Void {
        networking.get("/v1/calendarByCity", parameters: ["city": "Issaquah", "country": "USA"]) { result in
            switch result {
            case .success(let response):
                do {
                    print(response.dictionaryBody.debugDescription);
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
