//
//  TaskManagerUITests.swift
//  TaskManagerUITests
//
//  Created by PujaRaj on 25/02/25.
//

import XCTest

final class TaskManagerUITests: XCTestCase {

    
    let app = XCUIApplication()

       override func setUpWithError() throws {
           continueAfterFailure = false
           app.launch()
       }

       // ✅ Test Task Creation Flow
       func testTaskCreation() {
           let addButton = app.buttons["plus"]
           XCTAssertTrue(addButton.exists, "Add button should be visible")
           addButton.tap()

           let titleField = app.textFields["Title"]
           XCTAssertTrue(titleField.exists, "Title field should be visible")
           titleField.tap()
           titleField.typeText("Buy Groceries")

           let datePicker = app.datePickers.firstMatch
           XCTAssertTrue(datePicker.exists, "Date Picker should be present")

           let saveButton = app.buttons["Save"]
           XCTAssertTrue(saveButton.exists, "Save button should be visible")
           saveButton.tap()

           // Verify task appears in the list
           XCTAssertTrue(app.staticTexts["Buy Groceries"].exists, "Newly added task should appear in the list")
       }

    func testTaskFiltering() {
        let app = XCUIApplication()
        app.launch()

        let filterSegment = app.segmentedControls["FilterSegmentedControl"]
        XCTAssertTrue(filterSegment.exists, "Filter segmented control should be present")

        // ✅ Step 1: Add a new task (pending by default)
        app.buttons["plus"].tap()
        
        let titleField = app.textFields["Title"]
        XCTAssertTrue(titleField.exists, "Title field should be present")
        titleField.tap()
        titleField.typeText("Pending Task")
        
        // Save task
        app.buttons["Save"].tap()
        
        // ✅ Step 2: Wait for task list to update
        sleep(2)

        // ✅ Step 3: Select "Pending" filter
        filterSegment.buttons["Pending"].tap()

        // ✅ Step 4: Wait for the pending task to appear
        let pendingTask = app.staticTexts["Pending"]
        let exists = pendingTask.waitForExistence(timeout: 3)
        
        XCTAssertTrue(exists, "At least one pending task should appear")
    }
    
 
    
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    @MainActor
//    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()
//
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    @MainActor
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
