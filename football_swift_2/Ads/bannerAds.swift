//
//  bannerads.swift
//  football_1
//
//  Created by Tanvir on 26/2/24.
//

import Foundation
import SwiftUI
import GoogleMobileAds
let bannerAdSize = CGSize(width: 320, height: 50)
// Define a SwiftUI view to display Google Banner Ad
struct GoogleBannerAdView: View {
    @StateObject var viewmodel = ViewModel()
    @State private var adUnitID: String?
    @State private var googlealow: Int = 0;
    // Replace this with your actual Ad Unit ID
  

    // State variable to hold the banner view
 

    var body: some View {
        VStack {
            // Wrap UIKit view into SwiftUI using UIViewRepresentable
            if(adUnitID != nil && googlealow == 1){
                BannerView(bannerid: adUnitID ?? "")
            }
        }.frame(width: 320, height: 50)
        // Load the ad when the view appears
        .onAppear {
            Task{
                let ads : Ads? = try await viewmodel.loadFromLocalStoreAds()
                if(ads != nil){
                    self.adUnitID = ads!.gBanner
                    self.googlealow = ads!.google ?? 0
                }
                
            }
            
        }
    }
}

// Define a UIViewRepresentable to wrap the GADBannerView into SwiftUI
struct BannerView: UIViewRepresentable {
  
    let bannerid : String
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(bannerAdSize))
        // Set your desired banner ad size
        bannerView.adUnitID = bannerid
        bannerView.rootViewController = UIApplication.shared.windows.last?.rootViewController
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            // Create a GADRequest object and set the scene property
            let request = GADRequest()
            request.scene = windowScene

            // Load the ad with the request
            bannerView.load(request)
        } else {
            print("No window scene available.")
        }
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
        guard let bannerView = uiView as? GADBannerView else { return }
        bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: UIScreen.main.bounds.width, height: 50))
    }
}
