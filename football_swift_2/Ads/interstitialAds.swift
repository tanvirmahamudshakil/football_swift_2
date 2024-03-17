//
//  InterstitialAdView.swift
//  football_ios
//
//  Created by Tanvir on 19/1/24.
//

import Foundation
import SwiftUI
import GoogleMobileAds
import Foundation


import GoogleMobileAds
import UIKit

class ViewController: UIViewController, GADFullScreenContentDelegate {
  @StateObject var viewmodel = ViewModel()
  private var ginterstital: String?
  private var googlealow: Int = 0;
  private var interstitial: GADInterstitialAd?
    var instantshow : Bool = false
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
      
    let request = GADRequest()
      Task{
        var ads: Ads? = try await viewmodel.loadFromLocalStoreAds()
          if(ads != nil){
              self.ginterstital = ads!.gInterstitial
              self.googlealow = ads!.google ?? 0
              let click = ads!.adsClick ?? 0
               
                if(ginterstital != nil && googlealow == 1 && clickAds(adsClick: click) == true && instantshow == false){
                    GADInterstitialAd.load(withAdUnitID: ginterstital!,request: request,
                        completionHandler: { [self] ad, error in
                            if let error = error {
                                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                          return
                            }
                        interstitial = ad
                        interstitial?.fullScreenContentDelegate = self
                        guard let root = UIApplication.shared.windows.last?.rootViewController else {
                            return
                        }
                        interstitial!.present(fromRootViewController: root)
                      }
                    )
                }else if(ginterstital != nil && googlealow == 1  && instantshow == true){
                    GADInterstitialAd.load(withAdUnitID: ginterstital!,request: request,
                        completionHandler: { [self] ad, error in
                            if let error = error {
                                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                          return
                            }
                        interstitial = ad
                        interstitial?.fullScreenContentDelegate = self
                        guard let root = UIApplication.shared.windows.last?.rootViewController else {
                            return
                        }
                        interstitial!.present(fromRootViewController: root)
                      }
                    )
                }
          }
      }
  }
    
    
    func clickAds(adsClick: Int) -> Bool {
        let click : Int  = UserDefaults.standard.integer(forKey: "adsclick")
        if(click % adsClick == 0){
            UserDefaults.standard.set((click+1), forKey: "adsclick")
            return true
        }else{
            UserDefaults.standard.set((click+1), forKey: "adsclick")
            return false
        }
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
    }
    
}

