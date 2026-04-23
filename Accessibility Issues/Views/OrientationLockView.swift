import SwiftUI

// MARK: - Main Orientation Lock View
struct OrientationLockView: View {
    @EnvironmentObject var orientationManager: OrientationManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("App & Screen Orientation Lock")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Applications must not lock content to a single orientation (portrait or landscape). Locking orientation impacts users who need a specific orientation due to physical or situational constraints.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("WCAG 1.3.4 (Level AA) | Severity: Serious")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("Tap each case to navigate to a screen that actually locks orientation. Rotate your device to verify the lock.")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        // TC-01: Portrait-locked screen
                        NavigationLink(destination: PortraitLockedView()) {
                            OrientationTestCard(
                                testId: "TC-01",
                                title: "Portrait-Locked Screen",
                                description: "Screen locks to portrait only — will NOT rotate to landscape",
                                icon: "lock.rotation",
                                color: .red,
                                identifier: "tc01_portrait_locked"
                            )
                        }

                        // TC-02: Landscape-locked screen
                        NavigationLink(destination: LandscapeLockedView()) {
                            OrientationTestCard(
                                testId: "TC-02",
                                title: "Landscape-Locked Screen",
                                description: "Screen locks to landscape only — will NOT rotate to portrait",
                                icon: "lock.rotation",
                                color: .red,
                                identifier: "tc02_landscape_locked"
                            )
                        }

                        // TC-03: Screen that locks after loading
                        NavigationLink(destination: DelayedLockView()) {
                            OrientationTestCard(
                                testId: "TC-03",
                                title: "Programmatic Lock After Load",
                                description: "Screen starts unlocked then locks to portrait after 2 seconds — simulates runtime orientation override",
                                icon: "timer",
                                color: .red,
                                identifier: "tc03_delayed_lock"
                            )
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Positive Test Cases (VALID)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Positive Test Cases (VALID)")
                            .font(.headline)
                            .foregroundColor(Color(red: 0, green: 0.5, blue: 0))

                        Text("Tap each case to navigate to a screen that allows free rotation.")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        // TC-04: Freely rotating screen
                        NavigationLink(destination: FreeRotationView()) {
                            OrientationTestCard(
                                testId: "TC-04",
                                title: "Free Rotation — Both Orientations",
                                description: "Screen supports both portrait and landscape — rotates freely with device",
                                icon: "rotate.right",
                                color: Color(red: 0, green: 0.5, blue: 0),
                                identifier: "tc04_free_rotation"
                            )
                        }

                        // TC-05: Adaptive layout
                        NavigationLink(destination: AdaptiveLayoutView()) {
                            OrientationTestCard(
                                testId: "TC-05",
                                title: "Adaptive Layout Per Orientation",
                                description: "Screen adapts layout based on orientation — stacked in portrait, side-by-side in landscape",
                                icon: "rectangle.adaptive",
                                color: Color(red: 0, green: 0.5, blue: 0),
                                identifier: "tc05_adaptive_layout"
                            )
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Skip Condition Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Skip Condition Test Cases")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("These scenarios have essential orientation requirements — lock is acceptable per WCAG exception.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // TC-06: Essential landscape lock (piano)
                        Group {
                            Text("TC-06: Essential Orientation Lock — Piano App (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("A piano keyboard app requires landscape orientation for proper key layout — locking is essential for functionality")
                                .font(.caption)

                            HStack(spacing: 2) {
                                ForEach(["C", "D", "E", "F", "G", "A", "B"], id: \.self) { note in
                                    Text(note)
                                        .font(.caption2)
                                        .frame(width: 35, height: 80)
                                        .background(Color.white)
                                        .border(Color.black, width: 1)
                                }
                            }
                            .padding()
                            .background(Color.orange.opacity(0.05))
                            .cornerRadius(8)
                            .accessibilityIdentifier("tc06_essential_landscape_piano")

                            Text("⏭️ SKIP: Landscape lock is essential for piano app functionality (WCAG exception)")
                                .font(.caption)
                        }

                        Divider()

                        // TC-07: Camera viewfinder
                        Group {
                            Text("TC-07: Camera Viewfinder — Essential Orientation (SKIP)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Camera apps may lock to specific orientation for viewfinder alignment — essential for functionality")
                                .font(.caption)

                            ZStack {
                                Color.black
                                VStack {
                                    Image(systemName: "camera.viewfinder")
                                        .font(.system(size: 40))
                                        .foregroundColor(.white)
                                    Text("Camera Viewfinder")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(height: 100)
                            .cornerRadius(8)
                            .accessibilityIdentifier("tc07_camera_essential")

                            Text("⏭️ SKIP: Camera viewfinder orientation lock is essential for functionality")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("")
        .onAppear {
            orientationManager.unlock()
        }
    }
}

// MARK: - Reusable Test Card
struct OrientationTestCard: View {
    let testId: String
    let title: String
    let description: String
    let icon: String
    let color: Color
    let identifier: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text("\(testId): \(title)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(color.opacity(0.05))
        .cornerRadius(8)
        .accessibilityIdentifier(identifier)
    }
}

// MARK: - TC-01: Portrait Locked View (VIOLATION)
struct PortraitLockedView: View {
    @EnvironmentObject var orientationManager: OrientationManager

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)

            Text("Portrait Locked")
                .font(.title)
                .fontWeight(.bold)

            Text("This screen is locked to PORTRAIT orientation.\nTry rotating your device — it will NOT rotate.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Label("Orientation: Portrait Only", systemImage: "iphone")
                Label("Landscape: Blocked", systemImage: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
            .padding()
            .background(Color.red.opacity(0.1))
            .cornerRadius(10)

            Text("⚠️ VIOLATION: Screen does not rotate to landscape")
                .font(.caption)
                .foregroundColor(.red)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .accessibilityIdentifier("portrait_locked_screen")
        .onAppear {
            orientationManager.lockPortrait()
        }
        .onDisappear {
            orientationManager.unlock()
        }
        .navigationTitle("TC-01: Portrait Lock")
    }
}

// MARK: - TC-02: Landscape Locked View (VIOLATION)
struct LandscapeLockedView: View {
    @EnvironmentObject var orientationManager: OrientationManager

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)

            Text("Landscape Locked")
                .font(.title)
                .fontWeight(.bold)

            Text("This screen is locked to LANDSCAPE orientation.\nTry rotating your device — it will NOT rotate.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                Label("Orientation: Landscape Only", systemImage: "iphone.landscape")
                Label("Portrait: Blocked", systemImage: "xmark.circle.fill")
                    .foregroundColor(.red)
            }
            .padding()
            .background(Color.red.opacity(0.1))
            .cornerRadius(10)

            Text("⚠️ VIOLATION: Screen does not rotate to portrait")
                .font(.caption)
                .foregroundColor(.red)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .accessibilityIdentifier("landscape_locked_screen")
        .onAppear {
            orientationManager.lockLandscape()
        }
        .onDisappear {
            orientationManager.unlock()
        }
        .navigationTitle("TC-02: Landscape Lock")
    }
}

// MARK: - TC-03: Delayed Lock View (VIOLATION)
struct DelayedLockView: View {
    @EnvironmentObject var orientationManager: OrientationManager
    @State private var isLocked = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                .font(.system(size: 60))
                .foregroundColor(isLocked ? .red : .green)

            Text(isLocked ? "Orientation LOCKED" : "Orientation Unlocked...")
                .font(.title)
                .fontWeight(.bold)

            Text(isLocked
                 ? "Screen is now locked to portrait.\nDevice rotation is blocked."
                 : "Screen will lock to portrait in 2 seconds...\nTry rotating now — it works!")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            if isLocked {
                VStack(alignment: .leading, spacing: 8) {
                    Label("Locked via: programmatic override", systemImage: "gearshape.fill")
                    Label("UIDevice.setValue forced portrait", systemImage: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)

                Text("⚠️ VIOLATION: Orientation was locked programmatically after screen loaded")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView()
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .accessibilityIdentifier("delayed_lock_screen")
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                orientationManager.lockPortrait()
                isLocked = true
            }
        }
        .onDisappear {
            orientationManager.unlock()
        }
        .navigationTitle("TC-03: Delayed Lock")
    }
}

// MARK: - TC-04: Free Rotation View (PASS)
struct FreeRotationView: View {
    @EnvironmentObject var orientationManager: OrientationManager

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Image(systemName: "rotate.right")
                    .font(.system(size: 60))
                    .foregroundColor(.green)

                Text("Free Rotation")
                    .font(.title)
                    .fontWeight(.bold)

                Text("This screen supports BOTH orientations.\nRotate your device — it will follow!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Label("Portrait: Supported", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Label("Landscape: Supported", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Label("Current: \(geometry.size.width > geometry.size.height ? "Landscape" : "Portrait")", systemImage: "iphone")
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)

                Text("✅ PASS: Screen rotates freely with device orientation")
                    .font(.caption)
                    .foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(.systemBackground))
        .accessibilityIdentifier("free_rotation_screen")
        .onAppear {
            orientationManager.unlock()
        }
        .navigationTitle("TC-04: Free Rotation")
    }
}

// MARK: - TC-05: Adaptive Layout View (PASS)
struct AdaptiveLayoutView: View {
    @EnvironmentObject var orientationManager: OrientationManager

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height

            ScrollView {
                VStack(spacing: 20) {
                    Text("Adaptive Layout")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Current: \(isLandscape ? "Landscape — Side by Side" : "Portrait — Stacked")")
                        .font(.headline)
                        .foregroundColor(.green)

                    if isLandscape {
                        // Landscape: side-by-side
                        HStack(spacing: 16) {
                            AdaptiveCard(title: "Profile", icon: "person.fill", color: .blue)
                            AdaptiveCard(title: "Settings", icon: "gearshape.fill", color: .purple)
                            AdaptiveCard(title: "Activity", icon: "chart.bar.fill", color: .orange)
                        }
                        .padding(.horizontal)
                    } else {
                        // Portrait: stacked
                        VStack(spacing: 12) {
                            AdaptiveCard(title: "Profile", icon: "person.fill", color: .blue)
                            AdaptiveCard(title: "Settings", icon: "gearshape.fill", color: .purple)
                            AdaptiveCard(title: "Activity", icon: "chart.bar.fill", color: .orange)
                        }
                        .padding(.horizontal)
                    }

                    Text("✅ PASS: Layout adapts to orientation — content accessible in both")
                        .font(.caption)
                        .foregroundColor(Color(red: 0, green: 0.5, blue: 0))
                        .padding()
                }
                .padding(.top)
            }
        }
        .background(Color(.systemBackground))
        .accessibilityIdentifier("adaptive_layout_screen")
        .onAppear {
            orientationManager.unlock()
        }
        .navigationTitle("TC-05: Adaptive Layout")
    }
}

struct AdaptiveCard: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    NavigationView {
        OrientationLockView()
            .environmentObject(OrientationManager.shared)
    }
}
