//
//  homepage.swift
//  football_1
//
//  Created by Tanvir on 21/2/24.
//

import SwiftUI

struct homepage: View {
    @State var selectTab : Int = 2;
    @State var selectDate: Date = Date()
    @StateObject var viewmodel = ViewModel()
    @State private var showingCredits = false
    
    var body: some View {
       
        NavigationView{
            ZStack{
                Color(.systemGroupedBackground)
                VStack {
                    TabbarViewPage(selectTab: $selectTab,selectDate: $selectDate)
                    if (viewmodel.loading){
                        ProgressView("Loading...")
                    }
                    ScrollView{
                        ForEach(0..<viewmodel.fixtures.count, id: \.self){ d in
                            LeagueUi(fixturelist: viewmodel.fixtures[d])
                        }
                    }
                    GoogleBannerAdView()
                }.navigationTitle("HomePage").navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading) {
                          Button(action: {
                              Router.shared.path.append(pageRoute(name: "stream"))
                          }) {
                              Image("live-tv").resizable().scaledToFit().frame(width: 20)
                          }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                          Button(action: {
                              Router.shared.path.append(pageRoute(name: "live"))
                          }) {
                              Image("football").resizable().scaledToFit().frame(width: 20)
                          }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                          Button(action: {
                              Router.shared.path.append(pageRoute(name: "league"))
                          }) {
                              Image("champions").resizable().scaledToFit().frame(width: 20)
                          }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                          Button(action: {
                              showingCredits.toggle()
                          }) {
                              Image("calendar").resizable().scaledToFit().frame(width: 20)
                          }
                        }
                    }
            }
            
        }.onChange(of: selectDate){i in
            viewmodel.fixtureGet(status: "all",date: formattedDate(i, format: "yyyy-MM-dd"))
        }.sheet(isPresented: $showingCredits) {
            VStack {
                DatePicker("date picjer", selection: $selectDate).datePickerStyle(GraphicalDatePickerStyle())
                    
            }.presentationDetents([.medium])
        }.onChange(of: selectDate){
            showingCredits = false
        }
        .onAppear{
            
            viewmodel.fixtureGet(status: "all",date: formattedDate(selectDate, format: "yyyy-MM-dd"))
        }
    }
}


struct TabbarViewPage : View {
    @Binding var selectTab: Int
    @Binding var selectDate: Date
    
    var body: some View{
        
        let listdate = dateGenerate(currentdate: selectDate)
        ScrollViewReader{scrollViewProxy in
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(Array(listdate.enumerated()), id: \.offset){index,i in
                        TextWidthReader(text: "\(formattedDate(i, format: "EEE dd MMM"))",index: index,selectTab: $selectTab,scrollreader: scrollViewProxy,selectDate: $selectDate, date: i)
                    }
                }
            }
        }.background(.white)
    }
    func dateGenerate(currentdate:Date) -> [Date] {
        let calendar = Calendar.current
        var listdate : [Date] = []
        for i in 1...7 {
            listdate.append(calendar.date(byAdding: .day, value: (i-3), to: Date()) ?? Date())
        }
        return listdate
    }
    
    
    func dateBefore(days: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -days, to: Date()) ?? Date()
    }
    
    func dateAfter(days: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: days, to: Date()) ?? Date()
    }
}


struct TextWidthReader: View {
    let text: String
    let index: Int
    @Binding var selectTab: Int
    var scrollreader : ScrollViewProxy
    @Binding var selectDate: Date
    let date: Date
    @State private var textWidth: CGFloat = .zero

    var body: some View {
        ZStack{
            Button(action: {
                withAnimation {
                selectDate = date;
                selectTab = index;
                    scrollreader.scrollTo(index, anchor: .center)
                }
               
            }, label: {
                Text(text)
                    .padding(.horizontal,5).foregroundColor(Color(selectTab == index ? .black:.systemGray)).font(.system(size: 13))
                    .background(GeometryReader { geometry in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: geometry.size)
                    })
                    .onPreferenceChange(SizePreferenceKey.self) { preferences in
                        self.textWidth = preferences.width
                       
                }
            })
           
            if(selectTab == index) {
                VStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                       .fill(Color.black)
                   .frame(width: textWidth, height: 3)
                   .border(Color.black, width: 2)
                }
            }
        }.frame(height: 40)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    homepage()
}
