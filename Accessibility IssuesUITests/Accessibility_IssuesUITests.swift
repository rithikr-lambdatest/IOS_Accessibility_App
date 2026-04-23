//
//  Accessibility_IssuesUITests.swifttestInspectTC04LinkElement
//  Accessibility IssuesUITests
//
//  Created by Tejas Amle on 30/05/25.
//

import XCTest

final class Accessibility_IssuesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testInspectTC04LinkElement() throws {
        let app = XCUIApplication()
        app.launch()

        // Navigate to View Type Label page
        app.buttons["View Type Label"].tap()

        // Wait for the page to load
        sleep(1)

        // Try to find TC-04 element by identifier
        let tc04 = app.descendants(matching: .any)["tc04_type_link_in_label"]
        if tc04.exists {
            print("=== TC-04 Element Found ===")
            print("Element Type: \(tc04.elementType.rawValue)")
            print("Label: \(tc04.label)")
            print("Identifier: \(tc04.identifier)")
            print("Is Hittable: \(tc04.isHittable)")
            print("Is Enabled: \(tc04.isEnabled)")
            print("===========================")
        } else {
            print("=== TC-04 element NOT found by identifier ===")
        }

        // Also dump all links on the page
        print("=== All Links on page ===")
        let links = app.links.allElementsBoundByIndex
        for (i, link) in links.enumerated() {
            print("Link[\(i)]: label='\(link.label)', type=\(link.elementType.rawValue), id='\(link.identifier)'")
        }

        // Also check buttons for "Privacy Policy link"
        print("=== All Buttons on page ===")
        let buttons = app.buttons.allElementsBoundByIndex
        for (i, btn) in buttons.enumerated() {
            if btn.label.contains("Privacy") || btn.label.contains("link") {
                print("Button[\(i)]: label='\(btn.label)', type=\(btn.elementType.rawValue), id='\(btn.identifier)'")
            }
        }

        // Check staticTexts too
        print("=== Static texts with 'link' ===")
        let texts = app.staticTexts.allElementsBoundByIndex
        for (i, txt) in texts.enumerated() {
            if txt.label.contains("Privacy") {
                print("StaticText[\(i)]: label='\(txt.label)', type=\(txt.elementType.rawValue)")
            }
        }
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
