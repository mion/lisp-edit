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

+ (Node *)nodeWithValue:(id)value;
- (id)initWithValue:(id)value;
- (BOOL)isString;
- (BOOL)isNumber;
- (BOOL)isArray;
- (NSArray<Node *> *)siblings;
- (void)replaceValue:(id)newValue;
- (Node *)remove;
- (BOOL)canInsertNext;
- (Node *)insertNext:(id)value;
- (BOOL)canInsertChild;
- (Node *)insertChild:(id)value;

@property(nonatomic, readonly) id value;
@property(nonatomic, weak) NSArray<Node *> *children;
@property(nonatomic, weak) Node *parent;
@property(nonatomic, weak) Node *next;
@property(nonatomic, weak) Node *previous;

@end
