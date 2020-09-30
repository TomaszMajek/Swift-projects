import XCTest

import producentTests

var tests = [XCTestCaseEntry]()
tests += producentTests.allTests()
XCTMain(tests)
