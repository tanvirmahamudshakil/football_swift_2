import SwiftUI
struct CusNavLink<Label: View, Destination: View>: View {

    let destination: Destination
    let label : Label
    let isActive: Binding<Bool>?

    init(destination: Destination, isActive: Binding<Bool>? = nil, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
        self.isActive = isActive
    }

    var body: some View {
        if let isActive = isActive {
            NavigationLink(
                destination: destination
                .navigationBarHidden(true),
                isActive: isActive,
                label:{
                    label
                })
        } else {
            NavigationLink(
                destination: destination
                .navigationBarHidden(true),
                label:{
                    label
                })
        }
    }
}
