//
//  M3u8View.swift
//  football_1
//
//  Created by Tanvir on 29/2/24.
//

import SwiftUI
import VideoPlayerContainer
import AVFoundation

struct M3u8Player: View {
    let m3u8URLs: [String]
    @StateObject var context = Context()
    @State var orientation = UIDevice.current.orientation
    @State var selectindex : Int = 0
    @State var isFullScreen : Bool = false
    var body: some View {
        GeometryReader{proxy in
            VStack{
                PlayerWidget(context, launch: [])
                .frame(maxHeight: isFullScreen ? .infinity : proxy.size.width * 0.5625)
                .background(.black)
                if !isFullScreen {
                    List(0..<(m3u8URLs.count), id: \.self){i in
                        Button(action: {
                            selectindex = i
                            let item = AVPlayerItem(url: URL(string: m3u8URLs[selectindex])!)
                            context.render.player.replaceCurrentItem(with: item)
                            context.render.player.play()
                        }, label: {
                            Text("Stream \(i+1)")
                        })
                       
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { _ in
            self.orientation = UIDevice.current.orientation
            if UIDevice.current.orientation.isLandscape {
                context.status.toFullScreen()
            } else {
                context.status.toHalfScreen()
            }
        })
        .onAppear{
            context.control.configure(.halfScreen(.center)) {[
                PlaybackWidget(),
            ]}
            context.control.configure(.fullScreen(.center)) {[
                PlaybackWidget(),
            ]}
            context.control.configure(.fullScreen(.top1)) {[
                  BackWidget(),
                  SpacerWidget(),

            ]}
            AppDelegate.orientationLock = .landscape
            context.status.toFullScreen()
            isFullScreen = true
            let item = AVPlayerItem(url: URL(string: m3u8URLs[selectindex])!)
            context.render.player.replaceCurrentItem(with: item)
            context.render.player.play()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {

    static var orientationLock = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if orientationLock == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}

#Preview {
    M3u8Player(m3u8URLs: [
        "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8",
        "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8",
    "http://stream.livenetsport.com:1935/cricket/2.stream/playlist.m3u8",
    
    ])
}
