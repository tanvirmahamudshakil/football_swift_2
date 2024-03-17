//
//  timerPage.swift
//  football_ios
//
//  Created by Tanvir on 9/2/24.
//

import SwiftUI

struct CountdownTimerView: View {
    let targetDate: Date // Target date to count down to
    @State private var timeRemaining: TimeInterval = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(targetDate: Date) {
        self.targetDate = targetDate
    }

    var body: some View {
        Text(timeString(time: timeRemaining))
            .onReceive(timer) { _ in
                updateTime()
            }
            .onAppear {
                updateTime()
            }
    }
    
    private func updateTime() {
        let currentDate = Date()
        timeRemaining = targetDate.timeIntervalSince(currentDate)
        if timeRemaining < 0 {
            timeRemaining = 0
            // Timer has reached the target date, you can perform any action here.
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


