//
//  HareTests.m
//  HareTests
//
//  Created by Gabriel Vieira on 6/10/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Interpreter.h"

@interface HareTests : XCTestCase

@end

@implementation HareTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    id square = @[@"def", @"square", @[@"x"], @[@"*", @"x", @"x"]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLiterals {
    Interpreter *interpreter = [Interpreter new];
    
    NSNumber *numberLiteral = (NSNumber *) [interpreter evaluate:@1];
    XCTAssert( [numberLiteral isKindOfClass:[NSNumber class]] , @"number literal" );
    XCTAssert( [numberLiteral isEqualToNumber:[NSNumber numberWithInt:1]] );
    
    NSString *stringLiteral = [interpreter evaluate:@"foo"];
    XCTAssert( [stringLiteral isKindOfClass:[NSString class]], @"string literal" );
    XCTAssert( [stringLiteral isEqualToString:@"foo"] );
    
}

/*
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/

@end
