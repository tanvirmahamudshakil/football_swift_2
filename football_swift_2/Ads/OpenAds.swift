//
//  openads.swift
//  football_1
//
//  Created by Tanvir on 26/2/24.
//

import Foundation
import UIKit
import GoogleMobileAds
import SwiftUI

struct AppOpenAdView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    let openadsid : String

    func makeUIViewController(context: Context) -> UIViewController {
        let adViewController = UIViewController()
        // Load the app open ad
        GADAppOpenAd.load(withAdUnitID: openadsid, request: GADRequest(), completionHandler: {(ad, error) in
        if let error = error {
           print("Failed to load app open ad with error: \(error.localizedDescription)")
           return
        }
            
        if let appOpenAd = ad {
           appOpenAd.fullScreenContentDelegate = context.coordinator
            
        do {
            try appOpenAd.present(fromRootViewController: adViewController)
        } catch {
              print("Failed to present app open ad with error: \(error.localizedDescription)")
           }
        }
        })
//        GADAppOpenAd.load(
//            withAdUnitID: openadsid,
//            request: GADRequest(),
//            orientation: UIApplication.shared.windows.first?.windowScene?.interfaceOrientation ?? .unknown
//        ) { (ad, error) in
//            if let error = error {
//                print("Failed to load app open ad with error: \(error.localizedDescription)")
//                return
//            }
//
//            if let appOpenAd = ad {
//                appOpenAd.fullScreenContentDelegate = context.coordinator
//
//                do {
//                    try appOpenAd.present(fromRootViewController: adViewController)
//                } catch {
//                    print("Failed to present app open ad with error: \(error.localizedDescription)")
//                }
//            }
//        }

        return adViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No need to implement anything here
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, GADFullScreenContentDelegate {
        func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
            print("App Open Ad recorded impression.")
        }

        func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
            print("App Open Ad failed to present with error: \(error.localizedDescription)")
        }

//        func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//            print("App Open Ad did present full screen content.")
//        }

        func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
            print("App Open Ad dismissed full screen content.")
            // Handle app open ad dismissal if needed
        }
    }
}
