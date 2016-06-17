//
//  ViewController.m
//  Hare
//
//  Created by Gabriel Vieira on 6/10/16.
//  Copyright © 2016 Hare. All rights reserved.
//

#import "ViewController.h"
#import "Node.h"

@interface ViewController ()

@property(nonatomic, strong) Node *rootNode;
@property(nonatomic, weak) Node *selectedNode;
@property(nonatomic, weak) IBOutlet UIView *canvas;

@end

@implementation ViewController

const CGFloat PADDING = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id el = @[@"hello", @[@1, @[@"foo", @2, @"'bar'"]], @3, @"'quux'"];
    _rootNode = [[Node alloc] initWithValue:el];
    _selectedNode = _rootNode;
    [self renderCanvas];
}

- (void)renderCanvas {
    UIView *renderedNode = [self node:_rootNode renderWithPadding:PADDING];
    [self.canvas addSubview:renderedNode];
}

- (void)clearCanvas {
    for (UIView *view in self.canvas.subviews) {
        [view removeFromSuperview];
    }
}

- (IBAction)upAction:(id)sender {
    if (_selectedNode.parent) {
        _selectedNode = _selectedNode.parent;
    }
    [self clearCanvas];
    [self renderCanvas];
}

- (IBAction)leftAction:(id)sender {
    if (_selectedNode.previous) {
        _selectedNode = _selectedNode.previous;
    }
    [self clearCanvas];
    [self renderCanvas];
}

- (IBAction)rightAction:(id)sender {
    if (_selectedNode.next) {
        _selectedNode = _selectedNode.next;
    }
    [self clearCanvas];
    [self renderCanvas];
}

- (IBAction)downAction:(id)sender {
    if (_selectedNode.children.count > 0) {
        _selectedNode = _selectedNode.children.firstObject;
    }
    [self clearCanvas];
    [self renderCanvas];
}

- (IBAction)insertNodeAction:(id)sender {
    
}

- (IBAction)replaceNodeAction:(id)sender {
    
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

- (UIView *)node:(Node *)node renderWithPadding:(CGFloat)padding {
    if ([node.value isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)node.value;
        UILabel *label = [self labelWithString:string];
        if ([node isEqual:_selectedNode]) {
            [label setBackgroundColor:[UIColor yellowColor]];
        }
        return label;
    } else if ([node.value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)node.value;
        UILabel *label = [self labelWithNumber:number];
        if ([node isEqual:_selectedNode]) {
            [label setBackgroundColor:[UIColor yellowColor]];
        }
        return label;
    } else if ([node.value isKindOfClass:[NSArray class]]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        UILabel *leftParens = [self labelWithString:@"("];
        [view addSubview:leftParens];
        for (NSUInteger idx = 0; idx < node.children.count; idx++) {
            Node *child = [node.children objectAtIndex:idx];
            UIView *childView = [self node:child renderWithPadding:padding];
            [self view:view addSubviewToTheRight:childView withPadding:padding];
        }
        UILabel *rightParens = [self labelWithString:@")"];
        [self view:view addSubviewToTheRight:rightParens withPadding:padding];
        view.frame = CGRectMakeWithViews(view.subviews, padding);
        if ([node isEqual:_selectedNode]) {
            [view setBackgroundColor:[UIColor yellowColor]];
        }
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
