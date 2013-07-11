//
//  IDMCaptionView.m
//  IDMPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "IDMCaptionView.h"
#import "IDMPhoto.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat labelPadding = 10;

// Private
@interface IDMCaptionView () {
    id<IDMPhoto> _photo;
    UILabel *_label;    
}
@end

@implementation IDMCaptionView

- (id)initWithPhoto:(id<IDMPhoto>)photo {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        _photo = photo;
        self.opaque = NO;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -100, 320, 130+100)];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = view.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0 alpha:0.0] CGColor], (id)[[UIColor colorWithWhite:0 alpha:0.8] CGColor], nil];
        [view.layer insertSublayer:gradient atIndex:0];
        [self addSubview:view];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [self setupCaption];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat maxHeight = 9999;
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;
    CGSize textSize = [_label.text sizeWithFont:_label.font 
                              constrainedToSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                  lineBreakMode:_label.lineBreakMode];
    return CGSizeMake(size.width, textSize.height + labelPadding * 2);
}

- (void)setupCaption {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(labelPadding, 0, 
                                                       self.bounds.size.width-labelPadding*2,
                                                       self.bounds.size.height)];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = UITextAlignmentCenter;
    _label.lineBreakMode = UILineBreakModeWordWrap;
    _label.numberOfLines = 3;
    _label.textColor = [UIColor whiteColor];
    _label.shadowColor = [UIColor blackColor];
    _label.shadowOffset = CGSizeMake(1, 1);
    _label.font = [UIFont systemFontOfSize:17];
    if ([_photo respondsToSelector:@selector(caption)]) {
        _label.text = [_photo caption] ? [_photo caption] : @" ";
    }
    
    [self addSubview:_label];
}

@end
