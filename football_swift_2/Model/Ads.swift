// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ads = try? JSONDecoder().decode(Ads.self, from: jsonData)

import Foundation

// MARK: - Ads
struct Ads: Codable {
    let appSwitch: Bool?
    let applink: String?
    let google: Int?
    let fb: Int?
    let streamByMatchID: Int?
    let streamByMatchIDPage: Int?
    let xoomSportsStream: Int?
    let phpStream: Int?
    let isportsAnimation: Int?
    let adsClick: Int?
    let onesignalappid: String?
    let gopenAds: String?
    let gBanner: String?
    let gInterstitial: String?
    let gvideoads: String?
    let fbBanner: String?
    let fbInterstitial: String?
    let fBvideoads: String?

    enum CodingKeys: String, CodingKey {
        case appSwitch = "app_switch"
        case applink = "applink"
        case google = "google"
        case fb = "fb"
        case streamByMatchID = "stream-by-match-id"
        case streamByMatchIDPage = "stream-by-match-id-page"
        case xoomSportsStream = "xoom-sports-stream"
        case phpStream = "php-stream"
        case isportsAnimation = "isports-animation"
        case adsClick = "ads_click"
        case onesignalappid = "onesignalappid"
        case gopenAds = "GopenAds"
        case gBanner = "GBanner"
        case gInterstitial = "GInterstitial"
        case gvideoads = "Gvideoads"
        case fbBanner = "FBBanner"
        case fbInterstitial = "FBInterstitial"
        case fBvideoads = "FBvideoads"
    }
}
