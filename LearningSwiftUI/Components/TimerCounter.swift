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
    var Timer : Timer?
    @Published var counter = 0
}
