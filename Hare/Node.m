//
//  Node.m
//  Hare
//
//  Created by Gabriel Vieira on 6/16/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import "Node.h"

@implementation Node

- (id)initWithValue:(id)value {
    self = [super init];
    if (self) {
        _value = value;
        if ([_value isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)_value;
            NSMutableArray<Node *> *children = [NSMutableArray arrayWithCapacity:arr.count];
            for (NSUInteger i = 0; i < arr.count; i++) {
                id val = arr[i];
                Node *child = [[Node alloc] initWithValue:val];
                child.parent = self;
                children[i] = child;
                if (i > 0) {
                    children[i].previous = children[i - 1];
                    children[i - 1].next = children[i];
                }
            }
            _children = children;
        }
    }
    return self;
}

- (BOOL)isString { return [self.value isKindOfClass:[NSString class]]; }
- (BOOL)isNumber { return [self.value isKindOfClass:[NSNumber class]]; }
- (BOOL)isArray{ return [self.value isKindOfClass:[NSArray class]]; }

- (NSArray<Node *> *)siblings {
    if (_parent) {
        return _parent.children;
    } else return @[];
}

@end
