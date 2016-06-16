//
//  ViewController.m
//  Hare
//
//  Created by Gabriel Vieira on 6/10/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UIView *canvas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id el = @[@"hello", @[@1, @2, @3], @"'world'", @42, @"foobar"];
    UIView *renderedEl = [self renderElement:el];
    
    [self.canvas addSubview:renderedEl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)view:(UIView *)view addSubviewToTheRight:(UIView *)childView withPadding:(CGFloat)padding {
    if (view.subviews.count > 0) {
        UIView *lastSubview = view.subviews.lastObject;
        [view addSubview:childView];
        childView.frame = CGRectMake(
                            lastSubview.frame.origin.x + lastSubview.frame.size.width + padding,
                            lastSubview.frame.origin.y,
                            childView.frame.size.width,
                            childView.frame.size.height);
    } else {
        [view addSubview:childView];
    }
}

CGRect CGRectMakeWithViews(NSArray *arr, CGFloat padding) {
    CGFloat totalWidth = 0;
    CGFloat maxHeight = 0;
    for (NSUInteger idx = 0; idx < arr.count; idx++) {
        UIView *v = arr[idx];
        totalWidth += v.frame.size.width;
        if (v.frame.size.height > maxHeight) {
            maxHeight = v.frame.size.height;
        }
        if (idx < arr.count - 1) {
            totalWidth += padding;
        }
    }
    return CGRectMake(0, 0, totalWidth, maxHeight);
}

- (UIView *)renderElement:(id)element {
    if ([element isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)element;
        UILabel *label = [self labelWithString:string];
        return label;
    } else if ([element isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)element;
        UILabel *label = [self labelWithNumber:number];
        return label;
    } else if ([element isKindOfClass:[NSArray class]]) {
        CGFloat const PADDING = 5;
        NSArray *array = (NSArray *)element;
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *leftParens = [self labelWithString:@"("];
        [view addSubview:leftParens];
        for (NSUInteger idx = 0; idx < array.count; idx++) {
            id childElement = [array objectAtIndex:idx];
            UIView *childView = [self renderElement:childElement];
            [self view:view addSubviewToTheRight:childView withPadding:PADDING];
        }
        UILabel *rightParens = [self labelWithString:@")"];
        [self view:view addSubviewToTheRight:rightParens withPadding:PADDING];
        view.frame = CGRectMakeWithViews(view.subviews, PADDING);
        return view;
    } else {
        return [[UIView alloc] initWithFrame:CGRectZero]; // empty view
    }
}

- (UILabel *)labelWithString:(NSString *)string {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setText:string];
    if ([string hasPrefix:@"'"] && [string hasSuffix:@"'"]) {
        [label setTextColor:[UIColor blueColor]];
    }
    [label sizeToFit];
    return label;
}

- (UILabel *)labelWithNumber:(NSNumber *)number {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setText:[number stringValue]];
    [label setTextColor:[UIColor redColor]];
    [label sizeToFit];
    return label;
}

@end
