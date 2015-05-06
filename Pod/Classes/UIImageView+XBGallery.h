//
//  UIImageView+XBGallery.h
//  Pods
//
//  Created by Binh Nguyen Xuan on 4/15/15.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (XBGallery)

- (void)loadImage:(int)imageId;
- (void)loadImage:(int)imageId withIndicatorStyle:(UIActivityIndicatorViewStyle)style;

@end
