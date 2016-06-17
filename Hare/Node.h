//
//  Node.h
//  Hare
//
//  Created by Gabriel Vieira on 6/16/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Node : NSObject

- (id)initWithValue:(id)value;
- (BOOL)isString;
- (BOOL)isNumber;
- (BOOL)isArray;
- (NSArray<Node *> *)siblings;

@property(nonatomic, readonly) id value;
@property(nonatomic, readonly) NSArray<Node *> *children;
@property(nonatomic, weak) Node *parent;
@property(nonatomic, weak) Node *next;
@property(nonatomic, weak) Node *previous;

@end
