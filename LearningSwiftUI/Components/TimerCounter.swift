//
//  TimerCounter.swift
//  LearningSwiftUI
//
//  Created by Kynan Song on 09/03/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import Foundation
import Combine

class TimerCounter: ObservableObject {
    var timer : Timer?
    @Published var counter = 0
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        counter += 1
        //Whenever the counter changes, it will publish itself to any subscribers.
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
}
