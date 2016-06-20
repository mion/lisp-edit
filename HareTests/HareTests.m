//
//  HareTests.m
//  HareTests
//
//  Created by Gabriel Vieira on 6/10/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Interpreter.h"
#import "Node.h"

@interface HareTests : XCTestCase

@end

@implementation HareTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
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

- (void)testNodeConstructor {
    Node *num = [Node nodeWithValue:@123];
    XCTAssert( [num.value isEqualToNumber:@123] );
    
    Node *str = [Node nodeWithValue:@"foo"];
    XCTAssert( [str.value isEqualToString:@"foo"] );
    
    Node *arr = [Node nodeWithValue:@[@1, @"two", @[]]];
    NSArray *arrValue = @[@1, @"two", @[]];
    XCTAssert( [arr.value isEqualToArray:arrValue] );
    XCTAssert( arr.children.count == 3 );
    XCTAssert( arr.parent == nil );
    XCTAssert( arr.children[0].parent == arr );
    XCTAssert( arr.children[1].parent == arr );
    XCTAssert( arr.children[2].parent == arr );
    XCTAssert( [arr.children[0].value isEqualToNumber:@1] );
    XCTAssert( [arr.children[1].value isEqualToString:@"two"] );
    XCTAssert( [arr.children[2].value isEqualToArray:@[]] );
}

- (void)testNodeInsert {
    Node *root = [Node nodeWithValue:@[@1, @3, @4]];
    Node *one = root.children.firstObject;
    Node *two = [one insertNext:[Node nodeWithValue:@2]];
    XCTAssert( [two.value isEqualToNumber:@2] );
    XCTAssert( root.children.count == 4 );
    XCTAssert( [two.next.value isEqualToNumber:@3] );
    XCTAssert( [two.previous.value isEqualToNumber:@1] );
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
