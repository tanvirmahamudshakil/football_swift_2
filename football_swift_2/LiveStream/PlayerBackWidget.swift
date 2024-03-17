//
//  PlayBackWidget.swift
//  football_1
//
//  Created by Tanvir on 29/2/24.
//

import SwiftUI
import VideoPlayerContainer
import Combine

fileprivate class PlaybackService: Service {
    
    private var rateObservation: NSKeyValueObservation?
    
    private var statusObservation: NSKeyValueObservation?
    
    @ViewState var playOrPaused = false
    
    @ViewState var clickable = false
    
    required init(_ context: Context) {
        super.init(context)
        
        rateObservation = context.render.player.observe(\.rate, options: [.old, .new, .initial]) { [weak self] player, change in
            self?.playOrPaused = player.rate > 0
        }
        
        statusObservation = context.render.player.observe(\.status, options: [.old, .new, .initial]) { [weak self] player, change in
            self?.clickable = player.status == .readyToPlay
        }
    }
    
    func didClick() {
        guard let context else { return }
        if context.render.player.rate == 0 {
            context.render.player.play()
        } else {
            context.render.player.pause()
        }
    }
}

struct PlaybackWidget: View {
    var body: some View {
        WithService(PlaybackService.self) { service in
            Image(systemName: service.playOrPaused ? "pause.fill" : "play.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .disabled(!service.clickable)
                .onTapGesture {
                    service.didClick()
                }
        }
    }
}

struct BackWidget: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            AppDelegate.orientationLock = .portrait
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward").frame(width: 25, height: 35).foregroundColor(.white)
        })
    }
}

struct SpacerWidget: View {
    let space: CGFloat?
    init(_ space: CGFloat? = nil) {
        self.space = space
    }
    var body: some View {
        Spacer().frame(width: space)
    }
}

