//
//  WebView.swift
//  football_ios
//
//  Created by Tanvir on 18/1/24.
//

import SwiftUI

struct WebView: View {
    var urlString: String
    var adsviewcontroller = ViewController()
    var body: some View {
        WebViewContainer(urlString: urlString).onAppear{
            adsviewcontroller.instantshow = true;
            adsviewcontroller.viewDidLoad()
        }

    }
}

#Preview {
    WebView(urlString: "http://www.google.com")
}
