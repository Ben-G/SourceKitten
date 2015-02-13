//
//  ModuleTests.swift
//  SourceKitten
//
//  Created by JP Simard on 2015-01-07.
//  Copyright (c) 2015 SourceKitten. All rights reserved.
//

import Foundation
import SourceKittenFramework
import XCTest

class ModuleTests: XCTestCase {
    func testModuleNilInPathWithNoXcodeProject() {
        let pathWithNoXcodeProject = NSFileManager.defaultManager().currentDirectoryPath.stringByAppendingPathComponent("Source")
        let model = Module(xcodeBuildArguments: [], name: nil, inPath: pathWithNoXcodeProject)
        XCTAssert(model == nil, "model initialization without any Xcode project should fail")
    }

    func testSourceKittenFrameworkDocsAreValidJSON() {
        let sourceKittenModule = Module(xcodeBuildArguments: ["-workspace", "SourceKitten.xcworkspace", "-scheme", "SourceKittenFramework"])!
        let docsJSON = sourceKittenModule.docs.description
        var error: NSError? = nil
        let jsonArray = NSJSONSerialization.JSONObjectWithData(docsJSON.dataUsingEncoding(NSUTF8StringEncoding)!, options: nil, error: &error) as! NSArray?
        XCTAssertNil(error, "JSON should be propery parsed")
        XCTAssertNotNil(jsonArray, "JSON should be propery parsed")
    }

    // This test previously failed, but succeeds as of Swift 1.2b1. Keeping as a regression test.
//    func testSourceKittenReturnsSameResponse() {
//        var lastResponse = ""
//        for i in 0..<5 {
//            autoreleasepool {
//                println(i)
//                let sourceKittenModule = Module(xcodeBuildArguments: ["-workspace", "SourceKitten.xcworkspace", "-scheme", "SourceKittenFramework"])!
//                let docsJSON = sourceKittenModule.docs.description
//                if i == 0 {
//                    lastResponse = docsJSON
//                } else {
//                    XCTAssertEqual(docsJSON, lastResponse, "current response should match last response")
//                    lastResponse = docsJSON
//                }
//            }
//        }
//    }
}
