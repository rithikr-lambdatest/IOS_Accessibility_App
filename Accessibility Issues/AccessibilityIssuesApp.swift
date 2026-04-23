import SwiftUI
import UIKit

// MARK: - Orientation Manager
class OrientationManager: ObservableObject {
    static let shared = OrientationManager()

    @Published var allowedOrientations: UIInterfaceOrientationMask = .all

    func lockPortrait() {
        allowedOrientations = .portrait
        rotateToOrientation(.portrait)
    }

    func lockLandscape() {
        allowedOrientations = .landscape
        rotateToOrientation(.landscapeRight)
    }

    func unlock() {
        allowedOrientations = .all
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let geometryPreferences = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: .all)
        windowScene.requestGeometryUpdate(geometryPreferences) { _ in }
    }

    private func rotateToOrientation(_ orientation: UIInterfaceOrientation) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let geometryPreferences = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: allowedOrientations)
        windowScene.requestGeometryUpdate(geometryPreferences) { _ in }
    }
}

// MARK: - App Delegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return OrientationManager.shared.allowedOrientations
    }
}

@main
struct AccessibilityIssuesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(OrientationManager.shared)
        }
    }
}