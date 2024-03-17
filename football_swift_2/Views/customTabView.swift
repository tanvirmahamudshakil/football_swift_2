//
//  customTabview.swift
//  football_ios
//
//  Created by Tanvir on 8/1/24.
//

import SwiftUI

struct customTabview: View {
    @Binding var tabIndex: Int
    @Binding var tabName: String
    var listname: [String];
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing: 20){
                ForEach(0..<listname.count, id: \.self){i in
                    TabBarButton(text: "\(listname[i])", isSelected: .constant(tabIndex == i))
                        .onTapGesture { onButtonTapped(index: i) }
                }
                Spacer()
            }
        }
        
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation {
            tabIndex = index
            tabName = listname[tabIndex]
        }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 0, edges: [.bottom], color: .black)
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}


