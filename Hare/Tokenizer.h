//
//  Tokenizer.h
//  Hare
//
//  Created by Gabriel Vieira on 6/10/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tokenizer : NSObject

- (id)initWithString:(NSString *)string;
- (NSArray *)tokenize;

@end
