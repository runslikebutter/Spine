//
//  RoutingTests.swift
//  Spine
//
//  Created by Ward van Teijlingen on 19-02-15.
//  Copyright (c) 2015 Ward van Teijlingen. All rights reserved.
//

import UIKit
import XCTest

class RoutingTests: XCTestCase {
	var spine: Spine!
	var HTTPClient: CallbackHTTPClient!
	
	override func setUp() {
		super.setUp()
		spine = Spine(baseURL: NSURL(string:"http://example.com")!)
		HTTPClient = CallbackHTTPClient()
		spine.HTTPClient = HTTPClient
	}
	
    override func tearDown() {
        super.tearDown()
    }
	
	func testSetBaseURL() {
		spine.router.baseURL = NSURL(string:"http://github.com")!
		XCTAssertEqual(spine.router.baseURL, NSURL(string:"http://github.com")!, "Base URL not as expected.")
	}
	
	func testURLForResourceType() {
		let URL = spine.router.URLForResourceType("foos")
		let expectedURL = NSURL(string: "http://example.com/foos")!
		XCTAssertEqual(URL, expectedURL, "URL not as expected.")
	}
	
	func testURLForRelationship() {
		let resource = Foo()
		resource.id = "1"
		
		let URL = spine.router.URLForRelationship("relatedBars", ofResource: resource)
		let expectedURL = NSURL(string: "http://example.com/foos/1/links/relatedBars")!
		XCTAssertEqual(URL, expectedURL, "URL not as expected.")
	}
	
	func testURLForRelationshipWithIDs() {
		let resource = Foo()
		resource.id = "1"
		
		let URL = spine.router.URLForRelationship("relatedBars", ofResource: resource, ids: ["5", "6", "7"])
		let expectedURL = NSURL(string: "http://example.com/foos/1/links/relatedBars/5,6,7")!
		XCTAssertEqual(URL, expectedURL, "URL not as expected.")
	}
	
	func testURLForQuery() {
		var query = Query(resourceType: Foo.self, resourceIDs: ["1", "2"])
		query = query.whereProperty("equalProperty", equalTo: "equalValue")
//		query = query.whereProperty("greaterThanProperty", greaterThan: "greaterThanValue")
//		query = query.whereProperty("greaterThanOrEqualToProperty", greaterThanOrEqualTo: "greaterThanOrEqualToValue")
//		query = query.whereProperty("lessThanProperty", lessThan: "lessThanValue")
//		query = query.whereProperty("lessThanOrEqualToProperty", lessThanOrEqualTo: "lessThanOrEqualToValue")
//		query = query.whereProperty("notEqualToProperty", notEqualTo: "notEqualToValue")
		
		let URL = spine.router.URLForQuery(query)
		let expectedURL = NSURL(string: "http://example.com/foos/?filter[id]=1,2&filter[equalProperty]=equalValue")!
		
		XCTAssertEqual(URL, expectedURL, "URL not as expected.")
	}
}
