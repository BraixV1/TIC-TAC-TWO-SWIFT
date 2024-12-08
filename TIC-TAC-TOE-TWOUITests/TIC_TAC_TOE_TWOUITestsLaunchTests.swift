//
//  TIC_TAC_TOE_TWOUITestsLaunchTests.swift
//  TIC-TAC-TOE-TWOUITests
//
//  Created by Brajan Kukk on 23.11.2024.
//

import XCTest

final class TIC_TAC_TOE_TWOUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
