//
//  rotate.swift
//  football_ios
//
//  Created by Tanvir on 8/2/24.
//

import SwiftUI

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(RotateModifier(action: action))
    }
}

extension View {
    @ViewBuilder
    func forceRotation(orientation: UIInterfaceOrientationMask) -> some View {
        self.onAppear() {
//            AppDelegate.orientationLock = orientation
        }
        // Reset orientation to previous setting
//        let currentOrientation = AppDelegate.orientationLock
        self.onDisappear() {
//            AppDelegate.orientationLock = currentOrientation
        }
    }
}

struct RotateModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                UIDevice.current.beginGeneratingDeviceOrientationNotifications()
                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                    action(UIDevice.current.orientation)
                }
            }
    }
}

