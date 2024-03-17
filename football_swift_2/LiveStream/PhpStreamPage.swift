//
//  phpStreamPage.swift
//  football_ios
//
//  Created by Tanvir on 18/1/24.
//

import SwiftUI

struct PhpStreamPage: View {
    @StateObject var viewmodel = ViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ZStack{
            if viewmodel.livevideo1Loading{
                ProgressView("Loading...")
            }
            List(viewmodel.phpStreamData?.data ?? [], id: \.self){i in
                Section(header: Text(i.title ?? "")){
                    Button(action: {
                       
                        print("ascasc \(i.m3U8?.lowercased().hasSuffix(".m3u8")) == true)")
                        if((i.m3U8?.lowercased().hasSuffix(".m3u8")) == true){
                            var m3u8list: [String] = []
                            m3u8list.append(i.m3U8 ?? "")
                            Router.shared.path.append(M3u8View(m3U8: m3u8list ))
                        }else{
                            Router.shared.path.append(WebView2(url: i.m3U8 ?? "www.google.com"))
                        }
                        
                    }, label: {
                        HStack{
                            VStack{
                                HStack{
                                    AsyncImage(url: URL(string: i.imagea ?? "")){ image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                      Color.gray.opacity(0.1)
                                    }.frame(width: 50, height: 50)
                                    .cornerRadius(6)
                                   Text(i.teama ?? "")
                                }
                                HStack{
                                    AsyncImage(url: URL(string: i.imageb ?? "")){ image in
                                        image.resizable().scaledToFit()
                                    } placeholder: {
                                      Color.gray.opacity(0.1)
                                    }.frame(width: 50, height: 50)
                                    .cornerRadius(6)
                                   Text(i.teamb ?? "")
                                }
                            }
                            Spacer()
                            Image("live-tv")
                            .resizable()
                            .scaledToFit()
                            .colorMultiply(Color.brown)
                            .frame(width: 20)
                        }.foregroundColor(colorScheme == .dark ? .white : .black)
                    })
                }
            }
        }.refreshable {
            viewmodel.phpStreamGet()
        }
        .onAppear{
            viewmodel.phpStreamGet()
//            adsviewcontroller.instantshow = true;
//            adsviewcontroller.viewDidLoad()
        }
    }
}

#Preview {
    PhpStreamPage()
}
