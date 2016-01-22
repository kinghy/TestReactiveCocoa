//
//  TestReactiveCocoaTests.swift
//  TestReactiveCocoaTests
//
//  Created by  rjt on 16/1/18.
//  Copyright © 2016年 JYZD. All rights reserved.
//

import XCTest
@testable import TestReactiveCocoa


class TestReactiveCocoaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEntityContainsEntity(){
        let expectation = expectationWithDescription("That waitForExpectationsWithTimeout() will actually wait.")
        let param = PatchGetParam();
        let producer =  ESConnector().run(param);
        producer
            .on(failed:{
                    e in
                    print(e);
                    XCTAssert(false, "An aphorism about success.")
                    expectation.fulfill()
                },completed:{
                    print("completed")
                })
            .startWithNext {
                (bFlag,entity) in
                guard let e = entity as? PatchGetEntity else{
                    XCTAssert(false, "An aphorism about success.")
                    expectation.fulfill()
                    return
                }
                
                if e.resultDict.count>0 && e.res_data?.url != nil{
                    print("url is \((e.res_data?.url)! as String)");
                    XCTAssert(true, "An aphorism about success. ")
                    expectation.fulfill()
                }else{
                    XCTAssert(false, "An aphorism about success.")
                    expectation.fulfill()
                    return
                }

            };
        
        
        
        waitForExpectationsWithTimeout(15, handler: { error in
            
        })
    }
    
    func testEntityContainsArray(){
        let expectation = expectationWithDescription("That waitForExpectationsWithTimeout() will actually wait.")
        let param = MenuParam();
        let producer =  ESConnector().run(param);
        producer
            .on(failed:{
                e in
                print(e);
                XCTAssert(false, "An aphorism about success.")
                expectation.fulfill()
                },completed:{
                    print("completed")
            })
            .startWithNext {
                (bFlag,entity) in
                guard let e = entity as? MenuEntity else{
                    XCTAssert(false, "An aphorism about success.")
                    expectation.fulfill()
                    return
                }
                if e.menu.count>0{
                
                    for m:MenuRecordsEntity in e.menu{
                        print("url is \(m.name)! as String)");
                    }
                   
                    XCTAssert(true, "An aphorism about success. ")
                    expectation.fulfill()
                }else{
                    XCTAssert(false, "An aphorism about success.")
                    expectation.fulfill()
                    return
                }
                
                
        };
        
        
        
        waitForExpectationsWithTimeout(15, handler: { error in
            
        })
    }
    
    func testComplexEntity(){
        let expectation = expectationWithDescription("That waitForExpectationsWithTimeout() will actually wait.")
        let param = SchemesV2Param();
        let producer =  ESConnector().run(param);
        producer
            .on(failed:{
                e in
                print(e);
                XCTAssert(false, "An aphorism about success.")
                expectation.fulfill()
                },completed:{
                    print("completed")
            })
            .startWithNext {
                (bFlag,entity) in
                guard let e = entity as? SchemesV2Entity else{
                    XCTAssert(false, "An aphorism about success.")
                    expectation.fulfill()
                    return
                }
                if e.schemes.count>0{
                    
                    for m:SchemesV2RecordEntity in e.schemes{
                        print("distribution is \(m.distribution)");
                        print("t_profit is \(m.distribution?.t_profit)");
                    }
                    
                    XCTAssert(true, "An aphorism about success. ")
                    expectation.fulfill()
                }else{
                    XCTAssert(false, "An aphorism about success.")
                    expectation.fulfill()
                    return
                }
                
                
        };
        
        waitForExpectationsWithTimeout(1500, handler: { error in
            
        })
    }
    
    
}
