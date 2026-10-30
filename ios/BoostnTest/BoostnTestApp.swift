import SwiftUI

@main
struct BoostnTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

private let clubBlue = Color(red: 0x1E / 255, green: 0x3A / 255, blue: 0x8A / 255)

struct ContentView: View {
    @State private var purchaseStatus = "Purchase status: waiting…"

    var body: some View {
        VStack(spacing: 0) {
            // Dummy native section above the widget
            VStack(alignment: .leading, spacing: 4) {
                Text("FC Example Club")
                    .font(.title2.bold())
                Text("Dummy header (native UI above the widget)")
                    .opacity(0.8)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(clubBlue.ignoresSafeArea(edges: .top))

            // Boostn widget section
            BoostnWidgetView { orderId in
                purchaseStatus = "Purchase complete ✅ order: \(orderId)"
            }
            .padding(12)

            // Dummy native section below the widget
            VStack(spacing: 8) {
                Text(purchaseStatus)
                    .foregroundColor(Color(white: 0.27))
                HStack {
                    ForEach(["Home", "Tickets", "Profile"], id: \.self) { tab in
                        Text(tab)
                            .fontWeight(tab == "Tickets" ? .bold : .regular)
                            .foregroundColor(tab == "Tickets" ? clubBlue : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                }
            }
            .padding(12)
            .background(Color.white.ignoresSafeArea(edges: .bottom))
        }
        .background(Color(white: 0.95))
    }
}

/// Puts BoostnTicketsViewController into the SwiftUI screen as a section.
struct BoostnWidgetView: UIViewControllerRepresentable {
    var onPurchaseComplete: (String) -> Void

    func makeUIViewController(context: Context) -> BoostnTicketsViewController {
        let viewController = BoostnTicketsViewController()
        viewController.onPurchaseComplete = onPurchaseComplete
        return viewController
    }

    func updateUIViewController(_ viewController: BoostnTicketsViewController, context: Context) {
        viewController.onPurchaseComplete = onPurchaseComplete
    }
}
