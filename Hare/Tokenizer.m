//
//  Tokenizer.m
//  Hare
//
//  Created by Gabriel Vieira on 6/10/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import "Tokenizer.h"

@interface Tokenizer ()

@property(nonatomic, strong) NSString *string;

@end

@implementation Tokenizer

- (id)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        _string = string;
    }
    return self;
}

- (NSArray *)tokenize {
    return @[];
}

@end
