//
//  Parser.h
//  Hare
//
//  Created by Gabriel Vieira on 6/10/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

- (id)initWithTokens:(NSArray *)tokens;
- (id)parse;

@end