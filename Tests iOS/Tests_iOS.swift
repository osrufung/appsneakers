//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Oswaldo Rubio on 27/12/2020.
//

import XCTest
@testable import AppSneakers

class Tests_iOS: XCTestCase {
 
    func testSampleSnekaer() {
        let sneaker = Sneaker.sample
        XCTAssertEqual(sneaker.brand, "Nike")
        
    }
 
}
